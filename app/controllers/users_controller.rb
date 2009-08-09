require 'digest/sha1'
class UsersController < ApplicationController
  # Формирование данных для отображения базового меню-навигации
  before_filter :navigation_menu_init
  
  # Проверка на регистрацию
  before_filter :login_required, :except=>[:new, :create, :update]
  
  # Список пользователей системы
  def index
    @users = User.paginate(:all,
                           :order=>"created_at ASC", #ASC, DESC
                           :page => params[:page],
                           :per_page=>5
                           )
  end
  
  # кабинет пользователя
  def cabinet
  end
  
  # Анкета пользователя
  def profile
    @profile= current_user.profile
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end

  # Анкета пользователя
  def update
    @user= User.find_by_id(params[:id])
    @user.avatar= params[:user][:avatar]
    extension = File.extname(@user.avatar_file_name)
    @user.avatar.instance_write(:file_name, "#{Digest::SHA1.hexdigest(@user.login+Time.now.to_s)}#{extension}") 
    @user.save
    flash[:notice]= 'Аватара успешно обновлена'
    redirect_to(profile_users_path(:subdomain=>@subdomain)) and return
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    
    # Создать пользователя
    # Назначить роль зарегистрированного пользователя
    # Сохранить
    @user = User.new(params[:user])
    @user.set_role(Role.find_by_name('registrated_user'))
    @user.save
        
    if @user.errors.empty?
      # Если все успешно - создадим пользователю пустой профайл
      Profile.new(:user_id=>@user.id).save
      
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = t('user.auth.entered')
    else
      flash[:notice] = t('user.auth.cant_be_create')
      flash[:warning] = t('server.error')
      render :action => 'new'
    end
  end

end
