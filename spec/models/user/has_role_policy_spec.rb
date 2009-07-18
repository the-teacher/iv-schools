require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

###################################################################################################
# ������������ ������� ������� �������� ��������
###################################################################################################

describe '14:54 18.07.2009' do   
  # ������ ����� ���� � �������� ������� � ��������� pages[:tree]
  it '17:40 14.07.2009' do
    # ������� ����
    # ������� ������������ � ������ �����
    page_manager_role= Factory.create(:page_manager_role)
    admin_user= Factory.create(:admin,
      :role_id=>page_manager_role.id
    )
    # ������ ���� ��� ������� �� ����������� ����
    admin_user.role_policies_hash.should be_instance_of(Hash)
    # ������ ���� ��� ������� �������
    # ��������� � ����� ������ � ����� ������
    admin_user.has_role_policy?('pages', 'tree').should be_true
    admin_user.has_role_policy?(:pages, :manager).should be_true
    # ����� ������� ���� �� ������
    admin_user.has_role_policy?(:pages, :some_stupid_policy).should be_false
  end#17:40 14.07.2009

  # �������� ������� �������
  it '12:51 18.07.2009' do
    page_manager_role= Factory.create(:page_manager_role)
    @admin= Factory.create(:admin, :role_id=>page_manager_role.id)
    
    @admin.has_role_policy?(:pages, :tree).should     be_true
    @admin.has_role_policy?(:pages, :manager).should  be_true
    
    @admin.has_role_policy?(:page, :duck).should      be_false
    @admin.has_role_policy?(:pages, :duck).should     be_false
    
    @admin.has_role_policy?(:blocked, :yes).should    be_false
    @admin.has_role_policy?(:blocked, :no).should     be_true
  end# 12:51 18.07.2009
        
end
