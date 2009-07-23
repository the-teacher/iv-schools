class UsersController < ApplicationController
  # ������������ ������ ��� ����������� �������� ����-���������
  before_filter :navigation_menu_init
  
  # ������� �������� ������������ �������
  def index
    @pages_tree= Page.find_all_by_user_id(@user.id, :order=>"lft ASC")
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    
    # ������� ������������
    # ��������� ���� ������������������� ������������
    # ���������
    @user = User.new(params[:user])
    @user.set_role(Role.find_by_name('registrated_user'))
    @user.save
        
    if @user.errors.empty?
      # ���� ��� ������� - �������� ������������ ������ �������
      Profile.new(:user_id=>@user.id).save
      
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = Messages::User[:logined]
    else
      flash[:notice] = Messages::User[:cant_be_create]
      flash[:warning] = Messages::Server[:error]
      render :action => 'new'
    end
  end

end
