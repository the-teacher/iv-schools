class PagesController < ApplicationController  
  # Формирование данных для отображения базового меню-навигации
  before_filter :navigation_menu_init, :except=>[:show]
  
  # Проверка на регистрацию
  before_filter :login_required, :except=>[:index, :show]
  # Поиск ресурса для обработчиков, которым он требуется
  before_filter :find_page, :only=>[:show, :edit, :update, :destroy, :up, :down]
  # Проверка на политику доступа к обработчику, который не требует конкретного ресурса
  before_filter :access_to_controller_action_required, :only=>[:new, :create, :manager]
  # Проверка на политику доступа к обработчику, который требует ресурс
  before_filter :page_resourсe_access_required, :only=>[:edit, :update, :destroy, :up, :down]

  # Карта сайта
  def index
    # Для определенности отправим пользователя, заходящего на центральную страницу
    # В центральный поддомен
    redirect_to(root_path(:subdomain=>@user.login)) and return if (!current_subdomain && @user==User.find(:first))
    
    # Выбрать дерево страниц, только те поля, которые учавствуют отображении
    @pages_tree= Page.find_all_by_user_id(@user.id, :select=>'id, title, zip, parent_id', :order=>"lft ASC")
  end

  def show
    @page= Page.find_by_zip(params[:id])
    @parents= @page.self_and_ancestors if @page
    @siblings= @page.children if @page
  end
  
  # Карта сайта редактора
  def manager
    @pages_tree= Page.find_all_by_user_id(@user.id, :order=>"lft ASC")    
  end
  
  def new
    @parent= nil
    @parent= Page.find_by_zip(params[:parent_id]) if params[:parent_id]
    @page= Page.new
  end
  
  def create
    @page= Page.new(params[:page])
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
        @page.move_to_child_of(@parent) if @parent
        flash[:notice] = t('page.created')
        format.html { redirect_to(edit_page_path(@page.zip)) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    # before_filter
  end
  
  # PUT /pages/2343-5674-3345
  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = t('page.updated')
        format.html { redirect_back_or(manager_pages_path(:subdomain=>@subdomain)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def up
    if @page.move_possible?(@page.left_sibling)
      @page.move_left
      flash[:notice] = t('page.up')
    else
      flash[:notice] = t('page.cant_move')
    end
    redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
  end
  
  def down
    if @page.move_possible?(@page.right_sibling)
      @page.move_right
      flash[:notice] = t('page.down')
      redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
    else
      flash[:notice] = t('page.cant_be_move')
      redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
    end
  end

  def destroy
    if @page.children.count.zero?
      @page.destroy
      flash[:notice]= t('page.deleted')
    else
      flash[:notice]= t('page.has_children')
    end
    redirect_to(manager_pages_path(:subdomain=>@subdomain)) and return
  end
  
  protected

  # for :show, :edit, :update, :destroy, :up, :down
  # Поиск ресурса
  def find_page
    @page= Page.find_by_zip(params[:id])
    access_denied and return unless @page
  end
  
  # for :new, :create, :manager
  # :administrator, :pages
  # :pages, :new
  # Пользователь - владелец объекта и имеет соответствующие ролевые политики
  # Под объектом предполагается просматриваемый пользователь (текущий и просматриваемый должны совпадать)
  # !!!!! TODO: НАПИСАТЬ ТЕСТ: ИМЕЕТ ГРУППОВОЙ ДОСТУП К ДЕЙСТВИЮ, НО ПРОСМАТРИВАЕТ НЕ СЕБЯ !!!!!
  def access_to_controller_action_required
    access_denied if current_user.has_complex_block?(:administrator, controller_name)
    return true   if current_user.has_complex_access?(:administrator, controller_name)
    return true   if current_user.has_role_policy?(:administrator, controller_name)
    access_denied if current_user.has_complex_block?(controller_name, action_name)
    return true   if current_user.has_complex_access?(controller_name, action_name) && current_user.is_owner_of?(@user)
    return true   if current_user.has_role_policy?(controller_name, action_name) && current_user.is_owner_of?(@user)
    access_denied
  end
  
  # for :edit, :update, :destroy, :up, :down
  # :administrator, :pages
    # Есть персональные или групповые блокировки к ресурсу
    # Есть персональные или групповые разрешения к ресурсу (они выше по приоритету, чем общие блокировки)
    # Есть персональные или групповые блокировки
    # Есть персональные или групповые разрешения
  # :pages, :edit
    # Есть персональные или групповые блокировки к ресурсу
    # Есть персональные или групповые разрешения к ресурсу (они выше по приоритету, чем общие блокировки)
    # Есть персональные или групповые блокировки
    # Есть персональные или групповые разрешения
    # Пользователь - владелец ресурса и имеет соответствующие ролевые политики
    # Под ресурсом предполагается объект принадлежащий пользователю (текущий пользователь редактирует состояния своих объектов)
  def page_resourсe_access_required
      access_denied if current_user.has_complex_resource_block_for?(@page, :administrator, controller_name)
      return true   if current_user.has_complex_resource_access_for?(@page, :administrator, controller_name)
      return true   if current_user.has_role_policy?(:administrator, controller_name)
      access_denied if current_user.has_complex_block?(:administrator, controller_name)
      return true   if current_user.has_complex_access?(:administrator, controller_name)
      access_denied if current_user.has_complex_resource_block_for?(@page, controller_name, action_name)
      return true   if current_user.has_complex_resource_access_for?(@page, controller_name, action_name)
      access_denied if current_user.has_complex_block?(controller_name, action_name)
      return true   if current_user.has_complex_access?(controller_name, action_name)
      return true   if current_user.has_role_policy?(controller_name, action_name) && current_user.is_owner_of?(@page)
      access_denied
  end
end