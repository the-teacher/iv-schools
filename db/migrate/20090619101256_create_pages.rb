class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :user_id # �������� ��������

      t.string :author      # ����� ��������
      t.string :keywords    # �������� ����� ��������
      t.string :description # �������� ��������
      t.string :copyright   # ��������� �����

      t.string :title         # ��������� ��������
      t.text   :annotation    # ��������� (�� ���. annotatio � ���������) � ������� �������������� �������: ��������, ������ ��� �����.
      t.text   :content       # ���������� ��������

      # ��������� ������ (��������� ������� - nested sets)
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.text    :setting    # ����� ��������� �������� :: ��������������� ������ :: YAML :: ������ ���� ����������� ������ ���������
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
