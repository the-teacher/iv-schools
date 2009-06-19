class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string    :login
      t.string    :email
      t.string    :crypted_password,          :limit => 40
      t.string    :salt,                      :limit => 40
      t.datetime  :created_at
      t.datetime  :updated_at
      t.string    :remember_token
      t.datetime  :remember_token_expires_at

      # ��� �������������� ������ �������� � ��������
      t.string    :name               # ��� ������������ (������ ���)
      t.text      :setting            # ����� ��������� ��������
      t.integer   :sex, :default=>0   # ��� 1-�������, 2-�������, ����� - �� �����������
      t.datetime  :last_login_at      # ��� �� �����
      
      t.integer  "role_id"      # ������ �� ���� ������������ � �������
      t.integer  "profile_id"   # ������ �� ������� ������������

      t.timestamps
    end
  end

  def self.down
    drop_table "users"
  end
end
