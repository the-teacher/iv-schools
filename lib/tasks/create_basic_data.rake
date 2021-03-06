# Данные по умолчанию для сайта
namespace :db do
  # rake db:basic_data
  desc 'create basic data'
  
  task :basic_data => ['db:drop', 'db:create', 'db:migrate', 'db:roles:create', 'db:users:create', 'db:import:start', 'db:import:asks']
  # rake paperclip:refresh CLASS='StorageFile'
      
  # Раздел создания базовых пользователей системы
  namespace :users do
    # rake db:users:create
    desc 'create basic users'
    task :create => :environment do
    
      require "#{RAILS_ROOT}/spec/factories/users"
      require "#{RAILS_ROOT}/spec/factories/profile"
    
      # Создать администратора
      user= Factory.create(:user,
        :login => 'portal',
        :email => 'iv-schools@yandex.ru',
        :crypted_password=>'destruktor',
        :salt=>'salt',
        :name=>'Зыкин Илья Николаевич',
        :role_id=>Role.find_by_name('administrator').id
      )
      profile= Factory.create(:empty_profile, :user_id => user.id)
      
      #--------------------------------------------------------------
      ss= StorageSection.new(:user_id=>user.id, :name=>'Основное')
      ss.save!
      #--------------------------------------------------------------
      
      #-------------------------------------------------------------------------------------------------------
      # ~Администратор портала
      #-------------------------------------------------------------------------------------------------------
      
      logins= {
        :iv36=>'Jkd7DeR',
        :iv43=>'UyRtt89Z',
        :kohma5=>'WrTuN6Z',
        :kohma6=>'TyIhgLaP',
        :kohma7=>'XasTYikM',
        :kohma5vecher=>'Rj[vfDtxth'
      }

      logins.each_pair do |login, pwd|
        user= Factory.create(:user,
          :login => "#{login.to_s}",
          :email => "#{login.to_s}@iv-schools.ru",
          :crypted_password=>"#{pwd}",
          :salt=>'salt',
          :name=>"Администратор",
          :role_id=>Role.find_by_name('site_administrator').id
        )
        profile= Factory.create(:empty_profile, :user_id => user.id)
      end#logins.each
      
      # Администраторы страниц портала
      logins= {}#%w{ moderator001 moderator002 moderator003 } 
      logins.each do |login|
        user= Factory.create(:user,
          :login => "#{login.to_s}",
          :email => "#{login.to_s}@iv-schools.ru",
          :crypted_password=>"#{login}",
          :salt=>'salt',
          :name=>"Модератор",
          :role_id=>Role.find_by_name('page_administrator').id
        )
        #profile= Factory.create(:empty_profile, :user_id => user.id)
      end#logins.each
      
    end# db:users:create
  end#:users
end#:db