require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe '15:13 18.07.2009' do  

    before(:each) do
      # ����� � �������� ������� ����
      @page_manager_role= Factory.create(:page_manager_role)
      @admin= Factory.create(:admin, :role_id=>@page_manager_role.id)
    end
    
    def create_personal_policies
      # ������� 2 ������������ �������� ��� ������� ������������
      @page_manager_policy= Factory.create(:page_manager_personal_policy, :user_id=>@admin.id)
      @page_tree_policy= Factory.create(:page_tree_personal_policy,       :user_id=>@admin.id)
    end
    
    # ���������� ������� has_personal_access?(:section, :action)
    it '9:17 15.07.2009' do
      create_personal_policies
      @admin.has_personal_access?(:pages, :manager).should  be_true
      # ����� ���� �� ���������� - ������� false
      @admin.has_personal_access?(:pages0, :tree).should    be_false
      @admin.has_personal_access?(:pages, :duck).should     be_false
    end#9:17 15.07.2009
    
    # � ������������ ��� �� ����� ������������ ��������
    it '14:29 16.07.2009' do
      @admin.role_policies_hash.should      be_instance_of(Hash)
      @admin.personal_policies_hash.should  be_instance_of(Hash)
      @admin.personal_policies_hash.should  be_empty
      # ����� ���� �� ���������� - ������� false
      @admin.has_personal_access?(:pages, :manager).should  be_false
      @admin.has_personal_access?(:pages0, :tree).should    be_false
      @admin.has_personal_access?(:pages, :duck).should     be_false
    end#14:29 16.07.2009
    
    # ����������� ����������� ����������� �� ���-�� ��� �������
    # ������ ������ ������� false
    it '11:48 15.07.2009' do
      create_personal_policies
      @page_manager_policy.update_attributes(:counter=>15, :max_count=>14)
      @admin.has_personal_access?(:pages, :manager).should be_false
    end#11:48 15.07.2009
    
    # ���� ���� ����r ���� ������ �����
    # ������ ������ ������� false
    it '11:48 15.07.2009' do
      create_personal_policies
      @page_manager_policy.update_attributes({:start_at=>DateTime.now-3.days, :finish_at=>DateTime.now-1.minute})
      @admin.has_personal_access?(:pages, :manager).should be_false
    end#11:48 15.07.2009

    # ��������� ������������ ����������� ���������� �������� �� ������
    # ��������� ������� ��������, ������� ����� �������� � ��
    it '13:34 15.07.2009' do
      create_personal_policies
      # �� ���������
      @admin.has_personal_access?(:pages, :tree, :recalculate=> true).should    be_true
      @admin.has_personal_access?(:pages, :manager, :recalculate=> true).should be_true
      # �������� ������� ���������
      @page_manager_policy.update_attribute(:value, false)
      @admin.has_personal_access?(:pages, :manager).should                      be_true
      @admin.has_personal_access?(:pages, :manager, :recalculate=> true).should be_false
      # �������� ������� ���������
      @page_manager_policy.update_attribute(:value, true)
      @admin.has_personal_access?(:pages, :manager).should be_false
      @admin.has_personal_access?(:pages, :manager, :recalculate=> true).should be_true
    end#13:34 15.07.2009
    
end
