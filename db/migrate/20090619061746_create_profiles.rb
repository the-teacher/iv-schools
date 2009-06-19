class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|

      # ������ ������������
      t.integer   :user_id          # ���� �����������
      t.date      :birthday         # ���� ��������
      t.string    :native_town      # ������ �����
      
      # ���������� ������
      t.string    :home_phone       # �������� �������
      t.string    :cell_phone       # ��������� �������
      t.string    :icq              # icq
      t.string    :jabber           # jabber
      t.string    :public_email     # ��������� email
      t.string    :web_site         # web ����

      # ������ ������
      t.text    :activity         # ������������
      t.text    :interests        # ��������
      t.text    :music            # ������
      t.text    :movies           # ������
      t.text    :tv               # ��
      t.text    :books            # �����
      t.text    :citation         # ������
      t.text    :about_myself     # � ����
      
      # ��� � ������ �����
      t.string    :study_town         # �����
      t.string    :study_place        # �����
      t.string    :study_status       # ������
      
      # ��� � ������ �������
      t.string    :work_town         # �����
      t.string    :work_place        # �����
      t.string    :work_status       # ������ (���������)
      
      t.text      :setting          # ����� ��������� �������� ������
      
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
