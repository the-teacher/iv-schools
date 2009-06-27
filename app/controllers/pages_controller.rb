class PagesController < ApplicationController
  # ������������ ������ ��� ����������� �������� ����-���������
  before_filter :navigation_menu_init, :except=>[:show]
  
  # ����������� �������� ������� ��������
  # ����� ����� (������ ������� �����)
  def index
    # ������� ������ �������, ������ �� ����, ������� ���������� �����������
    @pages_tree= Page.find_all_by_user_id(@user.id, :select=>'id, title, zip, parent_id', :order=>"lft ASC")
  end

  # �������� ��������
  def show
    @page= Page.find_by_zip params[:id]
    @parents= @page.self_and_ancestors
    @siblings= @page.children
  end
    
  # ���������� ����� �����������
  # ������ ��� �������������� �������
  # ��������������� ������� ������� - ���� ������� [administrators::pages::manager]
  # ��������� ����� (�������� ��������� + [site_owner::pages::manager])
  # ���������� ������ [administrators::pages::manager], [site_owner::pages::manager] ��� ������� ���������

  #-------------------------------------------------------------------------------------------------------
  # �������� ����� ��������
  #-------------------------------------------------------------------------------------------------------
  def new
    @parent= nil
    @parent= Page.find_by_zip(params[:parent_id]) if params[:parent_id]
    @page= Page.new
  end
  
  # POST /pages
  # � �������� ������� �������� ����������� ��������������
  # �������� ������, � ���������������� �������
  # ������������ ���������� ����� ��������� �������� � ������ ���������
  # (���������� ������� ���������� pages::create �� ��������� � ������� ������������)
  def create
    # ������� ����� �������� � ���������� � ��� ������
    @page= Page.new(params[:page])
    
    #render :text=>params.inspect and return
    # ����� ��������
    # ������������� zip
    # ���������� ��������� ��������
      # �������� ������ ������������ ��������� � ������� ��� ���������
      # �.�. ���������� - ������������, ��������� ������
      # � ������� ��� � ���� ���������� @user, ������� ���������� ������
      # � �������� ������������ - �������� �������� �� �������������
      # ���� ������� ������������ � @user - ���� ���� - ������������� user_id=@user.id
      # �����, ��������� ����� ������� �������� ������������ � ������� �������� ������
      # � ����� ���������. administrators::pages::management ��� ������������ �������� pages::management
    
    @parent= nil
    @parent= Page.find_by_zip(params[:parent_id]) if params[:parent_id]
    zip= "#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}"
    while Page.find_by_zip(zip)
      zip= "#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}-#{(1000..9999).to_a.rand}"
    end
    @page.zip= zip
    @page.user_id= @user.id
        
    respond_to do |format|
      if @page.save
        # ���� ��������� �������� - ����� �������� ������� ��������
        @page.move_to_child_of(@parent) if @parent
        
        flash[:notice] = Messages::Pages[:created]
        format.html { redirect_to(edit_page_path(@page.zip)) }
      else
        format.html { render :action => "new" }
      end
    end
  end# create
  #-------------------------------------------------------------------------------------------------------
  # ~�������� ����� ��������
  #-------------------------------------------------------------------------------------------------------
  
  #-------------------------------------------------------------------------------------------------------
  # �������������� ��������
  #-------------------------------------------------------------------------------------------------------
  # � �������������� ������� �������� ����������� ��������������
  # �������� ������, � ���������������� �������
  # ������������ ���������� ����� ������������� ������ ��������
  # (���������� ������ pages::���� �� ��������� � ������� ��������)
  def edit
    @page= Page.find_by_zip(params[:id])
  end
  
  # PUT /pages/2343-5674-3345
  def update
    @page = Page.find_by_zip(params[:id])
    #render :text=>params.inspect and return
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = Messages::Pages[:updated]
        format.html { redirect_back_or(manager_pages_path(:subdomain=>@subdomain)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end# update
  #-------------------------------------------------------------------------------------------------------
  # ~�������������� ��������
  #-------------------------------------------------------------------------------------------------------

  # ����� ����� ���������
  def manager
    @pages_tree= Page.find_all_by_user_id(@user.id, :order=>"lft ASC")
  end# admin
  
  # ����������� �������� ����
  def down
    @page= Page.find_by_zip(params[:id])
    # ���� �������� ����������� ����
    if @page.move_possible?(@page.right_sibling)
      # ����������
      @page.move_right
      flash[:notice] = Messages::NestedSet[:element][:down]
      redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
    else
      flash[:notice] = Messages::NestedSet[:element][:cant_be_move]
      redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
    end
  end# down
  
  # ����������� �������� �����
  def up
    @page= Page.find_by_zip(params[:id])
    # ���� �������� ����������� �����
    if @page.move_possible?(@page.left_sibling)
      # ����������
      @page.move_left
      flash[:notice] = Messages::NestedSet[:element][:up]
    else
      flash[:notice] = Messages::NestedSet[:element][:cant_move]
    end
    
    redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
  end# up
  
  # ������� ��������
  def destroy
    @page= Page.find_by_zip(params[:id])
    if @page.children.count.zero?
      @page.destroy
      flash[:notice] = Messages::NestedSet[:element][:deleted]
    else
      flash[:notice] = Messages::NestedSet[:element][:has_children]
    end
    redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
  end# destroy
end
