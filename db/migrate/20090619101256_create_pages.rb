class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :user_id  # �������� ��������
      # ����������� ������, ���������������� ��������.
      # �������� � ����� �������� ����� ����� ����������
      # site.com/pages/134-234-223-126
      # ��� ������ ����������� ��������� ��������� ��� �������� ������ �� �������� ��������
      t.string  :zip_code

      t.string :author      # ����� ��������
      t.string :keywords    # �������� ����� ��������
      t.string :description # �������� ��������
      t.string :copyright   # ��������� �����

      t.string :title         # ��������� ��������
      t.text   :annotation    # ��������� (�� ���. annotatio � ���������) � ������� �������������� �������: ��������, ������ ��� �����.
      t.text   :content       # ���������� ��������
      
      t.text    :setting    # ����� ��������� �������� :: ��������������� ������ :: YAML :: ������ ���� ����������� ������ ���������
      
      # ��������� ������ (��������� ������� - nested sets)
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
            
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
