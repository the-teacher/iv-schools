require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe '15:21 18.07.2009' do  
    def create_users
      @admin= Factory.create(:admin)
      @ivanov= Factory.create(:ivanov)
      @petrov= Factory.create(:petrov)
    end

    def admin_has_ivanov_as_resource
      @resource_ivanov=Factory.create(:page_manager_personal_resource_policy, :user_id=>@admin.id)
      @resource_ivanov.resource= @ivanov
      @resource_ivanov.save
    end    
    
    # ������� ������������ ������������ �������� � ��������� ��������
    it '13:05 17.07.2009' do
      create_users

      # � ������������ ��� ��� �� ������ ������������� ����� - ������ ������� false
      @admin.has_personal_resource_access_for?(@ivanov, :profile, :edit).should be_false
            
      # ������������ �������� ������������ ��������� � ������� ������������
      personal_resource_policy0= Factory.create(:profile_edit_personal_resource_policy,
        :user_id=>@admin.id  
      )
      personal_resource_policy0.resource= @ivanov
      personal_resource_policy0.save
      # ������������ �������� ������������ ��������� � ������� ������������
      personal_resource_policy1= Factory.create(:profile_edit_personal_resource_policy,
        :user_id=>@admin.id  
      )
      # ���������� ����������� ������
      personal_resource_policy1.resource= @petrov
      personal_resource_policy1.save
      # �������� �� �������������� ������ � �������
      @admin.has_personal_resource_access_for?(@ivanov, :profile, :edit, :recalculate=>true).should be_true
    end# 13:05 17.07.2009    
end
