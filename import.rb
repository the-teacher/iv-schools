�����������, ������� ��������! =)

�������� � ���� �� � �������� ���������� ������� �����,
���������� ��� ������� ����� ������ � ����� �������� ���
��������� ������������ ��������������� ������, � ���� �� � ���,
��� ��������� � ������ ������ ����� ������ �� ������ ���������� ����� �
������������ ������ ����� �������� ���������� �� �������� ������������ ����..

..�����.. ���� ����� ��� ����� ��� � ����� ����� =)

..� �������� � ���� � ���, ��� �������� ��������� ����� ����� ������������� ������� �����
�� ��������� rake ������, ������������ ������� ������ �� ����� �� �� � ������.

� ���:

���������� ������:

�����:

��������� ������ � ����� MySQL ��

��1 => ����� �� 2� ������� php �������, ������� ����������� �� ������
��2 => ����� �� �� ������� � ���������� ������ ���������� ������

��1 - ������� � ���� ��������� �������� ������. ��1 �������������� ����������� ������������ ������ ������.
������� ������� ���������� ����� ���������� ������� ����� ������, ������� ����� ������� ������� �������������� �����.
�������� ���������� ��1 - ����������� �������� � ����� ��������� �� ����������.
� ��1 ������������ ������ ����������� ��������� - �������� �������� � ��������� ������� - ���������� � ������ � ������.

��2 - �� ��� ��������������������� Rails �������. �������� �������� �������, � ��������� � ����������� ������������ � ������,
��������������� ���������� ������ (�� ������ awesome_nested_set)

�������� ���� - ��������� ������� ������� � ����� ������ � ����������, ��� ���������� � ������,
������������� � ��������� �� ��������
(����� ���� ����������� ��������� ������������� ������ - �� ������� �� �� ������� html ���������
����� ������ �� ������������ �������������� �������� ������������� ������)

��������:

1. ������� ���� ��� rake � ��� ������:

lib\tasks\import.rake

namespace :db do
  namespace :import do
    # rake db:import:start
    desc 'import data form OldSite'
    task :start => :environment do    
      #
      #
      #
    end# db:import:start
  end# db:import
end#:db

� ��� ������ ���� ��� ���������� - ���� � ����� ������� �����,
������ �� ������ �����.

���������� � ����� ����� � ��� ����� ����������� �� ��������� - ��� �������� ���.
���������� � ������ ����� �� ���������� ����� ������������� ����� ����������� �� ActiveRecord::Base

class OldSiteConnect < ActiveRecord::Base
    establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "root",
      :password => "",
      :database => "OldSite",
      :encoding => "utf8"
    )
end

��� ����������� ������ �� OldSiteConnect ����� � ����� ������� ActiveRecord::Base
�, � ������ ������� ����� ����� �������� �� ������������ ����������.

�������� �������� ������ ���� � ���� � cp1251
����� :encoding => "utf8" ��������� ��� �� ������ � ��������������� ������ � utf8.

� ���� � ������ ���� ��� ������� � �������� ��� �������� ��������:

  class OldSiteSection < OldSiteConnect
      set_table_name "#{login}_sections"
  end    
  class OldSitePage < OldSiteConnect
      set_table_name "#{login}_pages"
  end
  class OldSiteLinkedFiles < OldSiteConnect
      set_table_name "#{login}_linked_files"
  end


set_table_name "#{login}_sections"

������� set_table_name ��������� ��� �������� ��� ������� ��������� � �������,
��������� � ���� ��� ������ � ��� ������� �� �� ���������.
�������� ������� �������� �������� ActiveRecord

������ ������ ��� �������� ���������� login ������������������ �� �������� � �
�� ���� ����� ������ �������� ��� � eval

=) �� �� ��.. �������� � ���� ����� =) ��������� ���� eval =) � ���� ��, ���� =)

����� �������� ���:

namespace :db do
  namespace :import do
    # rake db:import:start
    desc 'import data form OldSite'
    task :start => :environment do
    class OldSiteConnect < ActiveRecord::Base
        establish_connection(
          :adapter  => "mysql",
          :host     => "localhost",
          :username => "root",
          :password => "",
          :database => "OldSite",
          :encoding => "utf8"
        )
    end
    
    logins= %w{ town1 town2 town3 town4 town5 }
    
      logins.each do |login|
        user= User.find_by_login(login)
        
        eval("
          class OldSiteSection < OldSiteConnect
              set_table_name '#{login}_sections'
          end    
          class OldSitePage < OldSiteConnect
              set_table_name '#{login}_pages'
          end
          class OldSiteLinkedFiles < OldSiteConnect
              set_table_name '#{login}_linked_files'
          end
        ")
        
        sections= OldSiteSection.find(:all,  :order=>"Prev_Id ASC")
      end# logins.each do |login|
      
    end# db:import:start
  end# db:import
end#:db

� ��� - �� ����� ������ ������� �������������.
��� ������� ������������ ����� ���������������� ������ ������ ��� ������� � ������ �������� ������ ��.

������?! ������?!

sections= OldSiteSection.find(:all,  :order=>"Prev_Id ASC")

� ��� ��������� � ������ ���� � ������� �� ���� ��������� ������ ������� (��� ��� ���� ������� sections)

�� ���� ��������� sections ���� ������� ��������.
�������� ���� ��������� � ����� �� � ��������� �� ��� ������.
������ � ����� �� ����� �������� �� ����� ID �������, � �� ����� ��������� �� ������ ID.
������ ������ ID ����� ���������� ������, � �� ����� ID ����� ��� ������ ��� �������.
 
��� �� �������� ��� ��� � ����� �� ������������  - � ����� ������������� ������.
���� ������������� ���� - ��� ������ ID �������� (� ������ �� �� ��������� Prev_Id)
�������� ������������� ���� - ����� ID �������� � ����� ��.

��� �������� ������ �������� � ���� ��������� �� ������� ���� ���� - ������ ID => ����� ID
� ��� ������������� ���� �������� ������� ����������� �������� � ������, ���� � ������������� ���� ���� ������ ����������.

�� ����� ���� ��������� �� ������ �������� ������ - ���� �� � ��� ����� ������� - ���� �� ������ ��� � ����.

namespace :db do
  namespace :import do
  
    # rake db:import:start
    desc 'import data form OldSite'
    task :start => :environment do
    class OldSiteConnect < ActiveRecord::Base
        establish_connection(
          :adapter  => "mysql",
          :host     => "localhost",
          :username => "root",
          :password => "",
          :database => "OldSite",
          :encoding => "utf8"
        )
    end
        
    logins= %w{ town1 town2 town3 town4 town5 }
    
      logins.each do |login|
        user= User.find_by_login(login)
        
        eval("
          class OldSiteSection < OldSiteConnect
              set_table_name '#{login}_sections'
          end    
          class OldSitePage < OldSiteConnect
              set_table_name '#{login}_pages'
          end
          class OldSiteLinkedFiles < OldSiteConnect
              set_table_name '#{login}_linked_files'
          end
        ")
        
        # ���������� ��� ������� (���������� ��� ������)
        sections= OldSiteSection.find(:all,  :order=>"Prev_Id ASC")
        
        # ��� ��� ������������ ������� � ������ id
        ids_set= Hash.new
        
        sections.each do |s|
          # ������ id ��������
          old_id= s.Page_Id
          # ������ ��������
          basic_page= OldSitePage.find(old_id)
          
          title= basic_page.Description
          content= basic_page.Content
          
          page= Page.new( :user_id=>user.id,
                          :title=>title,
                          :content=>content
                         )
          page.save
          
          new_id= page.id
          
          # ���� � �����t ��������� ������� ����� id, �� �������� ����� ����������� � ��������
          page.move_to_child_of(Page.find(ids_set[s.Prev_Id])) if ids_set[s.Prev_Id]
          
          # �������� � ������ ������������ id
          ids_set[old_id] = new_id
        end# sections.each do |s|
        
      end# logins.each do |login|
    end# db:import:start
  end# db:import
end#:db

������� �������� ���������� gsub ��������� � ����� ���� ����� ���� ������� ��������,
� ��� �������� ���� ������ ������������ � html �����������.
����� ����, ����� ���� �������� ��� ���� � ������, ������� �� ��������� �����,
� ����� ������ ��� ����� �������� �������������� =)

  title= basic_page.Description.gsub("&gt;", '>').gsub("&lt;", '<').gsub("&quot;", "'")

  content= basic_page.Content.gsub("&gt;", '>').gsub("&lt;", '<').gsub("&quot;", "'")
  
  content= content.gsub("./files/common/", "/uploads/files/#{login}/")
  content= content.gsub("./files/pages/", "/uploads/files/#{login}/")
  
  content= content.gsub("./files/#{login}/common/", "/uploads/files/#{login}/")
  content= content.gsub("./files/#{login}/pages/", "/uploads/files/#{login}/")

� ��� � ��������, ��� � ������ ������ � �������� ���������� ������������� �����.
� �� ���� ���������� ���������� ������������ ������������ ����������� - � ������ �����
��� ������������� � �������� ����� � � ����� �������� ������ ������ �� ��������.

��� ����� �������� � ���� ��������

  # ����� ����� ���� ��� ����������� � ��������
  files= OldSiteLinkedFiles.find(:all, :conditions => ['Page_Id = ? and Linked = ?', old_id, 1])
  
Page_Id � ������ ������ ������� ID ��������, � Linked - ��� ���� ����, ��� ���� ������������,
��� ��������� ��������.

  content= basic_page.Content.gsub("&gt;", '>').gsub("&lt;", '<').gsub("&quot;", "'")

  # ���� ������ ��������� ������ �� ���� �� � ����������� �������� �����������
  # HTML ������ �� �������� �� �����
  (content = content + file_div(files) ) unless files.empty?

������� file_div(files) ������ ������������ HTML

��� �� �������� ������������ ������ HTML ��� � � ����� ������������ �������� �� ACTION VIEW

  def file_div(files)
    res= ""
    files.each do |f|
      res<< content_tag(:li, link_to(f.Description, f.Path) )
    end
    res= content_tag(:ul, res, :class=>:linked_files)
  end
  
������ � Rake content_tag � link_to �������� �� ��������.

� ������ ���:

  require 'action_view/helpers/tag_helper'
  require 'action_view/helpers/url_helper'
  class Helpers
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
  end
  
� ����� � file_div(files) ������� ��������� help= Helpers.new
�� �������� � ������ ������ �������.

�� �� ���� �� ������� ����� � ��� ������ - �� ��� �������� � ��� ������� =)

  require 'action_view/helpers/tag_helper'
  require 'action_view/helpers/url_helper'
  class Helpers
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
  end

  def file_div(files)
    help= Helpers.new
    res= ""
    files.each do |f|
      res<< help.content_tag(:li, help.link_to(f.Description, f.Path) )
    end
    res= help.content_tag(:ul, res, :class=>:linked_files)
  end

�� � ���������� �������

namespace :db do
  namespace :import do
  
    # rake db:import:start
    desc 'import data form OldSite'
    task :start => :environment do
    class OldSiteConnect < ActiveRecord::Base
        establish_connection(
          :adapter  => "mysql",
          :host     => "localhost",
          :username => "root",
          :password => "",
          :database => "OldSite",
          :encoding => "utf8"
        )
    end
    
    require 'action_view/helpers/tag_helper'
    require 'action_view/helpers/url_helper'
    class Helpers
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
    end

    def file_div(files)
      help= Helpers.new
      res= ""
      files.each do |f|
        res<< help.content_tag(:li, help.link_to(f.Description, f.Path) )
      end
      res= help.content_tag(:ul, res, :class=>:linked_files)
    end
    
    logins= %w{ town1 town2 town3 town4 town5 }
    
      logins.each do |login|
        user= User.find_by_login(login)
        
        eval("
          class OldSiteSection < OldSiteConnect
              set_table_name '#{login}_sections'
          end    
          class OldSitePage < OldSiteConnect
              set_table_name '#{login}_pages'
          end
          class OldSiteLinkedFiles < OldSiteConnect
              set_table_name '#{login}_linked_files'
          end
        ")
        
        #OldSitePage.find:first
        sections= OldSiteSection.find(:all,  :order=>"Prev_Id ASC")
        ids_set= Hash.new
        
        sections.each do |s|
          # ������ id ��������
          old_id= s.Page_Id
          # ������ ��������
          basic_page= OldSitePage.find(old_id)

          # ����� ����� ���� ��� ����������� � ��������
          files= OldSiteLinkedFiles.find(:all, :conditions => ['Page_Id = ? and Linked = ?', old_id, 1])

          title= basic_page.Description.gsub("&gt;", '>').gsub("&lt;", '<').gsub("&quot;", "'")
          content= basic_page.Content.gsub("&gt;", '>').gsub("&lt;", '<').gsub("&quot;", "'")
          
          # ������� ������ ������������� ������
          (content = content + file_div(files) ) unless files.empty?
          
          # �������� ��� ����
          content= content.gsub("./files/common/", "/uploads/files/#{login}/")
          content= content.gsub("./files/pages/", "/uploads/files/#{login}/")
          content= content.gsub("./files/#{login}/common/", "/uploads/files/#{login}/")
          content= content.gsub("./files/#{login}/pages/", "/uploads/files/#{login}/")

          page= Page.new( :user_id=>user.id,
                          :title=>title,
                          :content=>content
                         )
          page.save
          new_id= page.id
          # �������� � ������ ������������ id
          # ���� � ������� ��������� ����� ����� id
          page.move_to_child_of(Page.find(ids_set[s.Prev_Id])) if ids_set[s.Prev_Id]
          ids_set[old_id] = new_id
        end# sections.each do |s|
      end# logins.each do |login|
    end# db:import:start
  end# db:import
end#:db




  









