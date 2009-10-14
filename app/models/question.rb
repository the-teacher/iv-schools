class Question < ActiveRecord::Base
  belongs_to :user
  before_save :create_zip
  
  # ------------------------------------------------------------------
  # ������ ��������� state
  state_machine :state, :initial => :new_question do
    # ������ ������ ���������
    event :reading do
      # ����� ������ ��������������� � �������� ���� ���������
      transition :new_question => :seen
    end
    
    # ���������� ���������
    event :blocking do
      # �� ���� ��������� ����� delete ������ ������� � ���
      transition all - :deleted => :block
    end
    
    # ������������� ���������
    event :unblocking do
      # �� ��������� ���� ������� � ��������� �������������� ���������
      transition :block => :seen
    end
    
    # �������� ���������
    event :deleting do
      # �� ���� ��������� ������ ������� � ���
      transition all => :deleted
    end
  end
  
  # ------------------------------------------------------------------  
  # ������� ������� ������� zip ���
  def create_zip
    zip_code= "#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}"
    while self.class.to_s.camelize.constantize.find_by_zip(zip_code)
      zip_code= "#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}"
    end
    self.zip= zip_code
  end
end
