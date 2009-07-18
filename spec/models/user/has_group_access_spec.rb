require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe '15:18 18.07.2009' do
  # ����������� ����� ������ ������ �������
  before(:each) do
    # ����� � �������� ������� ����
    @page_manager_role= Factory.create(:page_manager_role)
    @admin= Factory.create(:admin, :role_id=>@page_manager_role.id)
  end

  def create_group_policies
    # ������� 2 ��������� �������� ��� ������� ������������(����)
    @page_manager_gpolicy=  Factory.create(:page_manager_group_policy,  :role_id=>@page_manager_role.id)
    @page_tree_gpolicy=     Factory.create(:page_tree_group_policy,     :role_id=>@page_manager_role.id)
  end
  
  # ��������� ������������ ����������� ���������� �������� �� ������
  # ��������� ������� ��������, ������� ����� �������� � ��
  it '13:34 15.07.2009' do
    create_group_policies
    #true
    @admin.has_group_access?(:pages, :manager, :recalculate=> true).should be_true
    #false
    @page_manager_gpolicy.update_attribute(:value, false)
    @admin.has_group_access?(:pages, :manager, :recalculate=> true).should be_false
    # ���������, �� �� ���������� ���� ��������� - ������ ���������� ���������� ��������
    @page_manager_gpolicy.update_attribute(:value, true)
    @admin.has_group_access?(:pages, :manager).should be_false
    # ������ �� ���������, �� ������ ����������� ��� ������� �������� ������ � ��
    @admin.has_group_access?(:pages, :manager, :recalculate=> true).should be_true
  end#13:34 15.07.2009
end
