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

      # Специальный маркер, идентифицирующий пользователя
      # Например к любому пользователю можно будет обращаться
      # site.com/users/1347-2346-2231
      # Что должно существенно упростить адресацию при диктовке адреса по телефону, например
      # Предполагается использовать для большинства объектов системы
      t.string  :zip
      
      # Все дополнительные данные хранятся в профайле
      t.string    :name               # Имя пользователя (Полное ФИО)
      t.text      :setting            # Набор различных настроек :: сериализованные данные :: YAML :: должен быть организован единый интерфейс
      t.integer   :sex, :default=>0   # Пол 1-женщина, 2-мужчина, иначе - не установлено
      t.datetime  :last_login_at      # Был на сайте
      
      t.integer  "role_id"      # Ссылка на Роль пользователя в системе
      t.integer  "profile_id"   # Ссылка на Профиль пользователя

      t.timestamps
    end
  end

  def self.down
    drop_table "users"
  end
end
