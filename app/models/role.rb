class Role < ActiveRecord::Base
  # ��������� �� ������ ���� ������
  # �������� ������ ���� ����� 30 ��������
  has_many :users
end
