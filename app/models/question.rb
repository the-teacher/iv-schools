class Question < ActiveRecord::Base    
  belongs_to :user
 
  # ���������
  #validates_presence_of :from
  #validates_presence_of :to
  #validates_presence_of :topic
  #validates_presence_of :question  
  #apply_simple_captcha

  # ���������� ����� ����� �����������
  before_save :prepare_fields
  
  # ���������� ����� ����� �����������
  def prepare_fields
    (self.question = self.question.mb_chars[0..600]) unless (self.question.nil? || self.question.blank?)
  end
  
  #new_question, seen, blocked, publicated, deleted
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
      transition all - :deleted => :blocked
    end
    
    # ���������� ���������
    event :publication do
      # �� �������������� � ����������
      transition :seen => :publicated
    end
    
    # ����� � ����������
    event :unpublication do
      # �� ��������������� � ������������ (����� � ����������)
      transition :publicated => :seen
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
  before_create :create_zip
  def create_zip
    zip_code= "#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}"
    while self.class.to_s.camelize.constantize.find_by_zip(zip_code)
      zip_code= "#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}"
    end
    self.zip= zip_code
  end
end
