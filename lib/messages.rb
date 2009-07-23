module Messages
  #Array.merge!
  # Messages::LOGINED
  # Сообщения генерируемые системой
  
  SITE_NAME= 'iv-schools.ru'

  # Messages::System[:have_no_users]
  # Сообщения для работы со страницами
  System={
    :have_no_users=>'В системе нет ни одного пользователя'
  }
  
  # Messages::User[:logined]
  # Сообщения для работы со страницами
  User={
    :updated=>"Спасибо за регистрацию в системе #{SITE_NAME}",
    :cant_be_create=>'Не удалось создать пользователя',
    :entered=>"Выполнен вход в систему #{SITE_NAME}",
    :logouted=>"Выход из системы #{SITE_NAME} успешно выполнен",
    :enter_error=>"Ошибка входа в систему #{SITE_NAME}. Возможно Логин или Пароль указаны не верно"
  }
  
  # Messages::UserValidation[:login_uniqueness]
  # Сообщения валидации модели пользователь
  UserValidation={
    :uniqueness_of_login=>'Данный Логин уже используется',
    :uniqueness_of_email=>'Данный Email уже используется',
    :presence_of_login_email=>'Поля Логин и Email не могут быть пустыми',
    :presence_of_password=>'Поле Пароль не может быть пустым',
    :presence_of_password_confirmation=>'Необходимо подтвердить пароль',
    :confirmation_of_password=>'Пароль не подтвердился',
    
    :length_of_password=>'Длина Пароля должна быть иной',
    :length_of_password_too_short=>'Пароль слишком короткий',
    :length_of_password_too_long=>'Пароль слишком длинный',
    
    :length_of_login=>'Логин должен содержать от 4 до 20 символов',
    :length_of_login_too_short=>'Логин должен содержать не менее 4 символов',
    :length_of_login_too_long=>'Логин должен содержать не более 20 символов',
    
    :length_of_email=>'Email должен содержать от 6 до 50 символов',
    :length_of_email_too_short=>'Email должен содержать не менее 5 символов',
    :length_of_email_too_long=>'Email должен содержать не более 50 символов'
  }
  
  # Messages::Server[:error]
  # Некотороы серверные сообщения
  Server={
    :error=>'Ошибка стороны сервера',
    :data_are_required=>'Для выполнения действия требуются дополнительные данные'
  }

  # Messages::Policies[:empty_section_name]
  # Сообщения модуля разграничения прав доступа
  Policies={
    :empty_section_name=>     'Не установлено имя раздела прав',
    :section_wrong_name=>     'Некорректное имя раздела прав',
    :section_rule_wrong_name=>'Некорректное имя правового правила в разделе: ',
    :section_destroy=>        'Раздел прав удален',
    :section_is_not_hash=>    'Раздел прав не является Хешем. Высока вероятность повреждения базы данных. Обратитесь к разработчику',
    :section_hasnt_rule=>     'Раздел не содержит указанного правила',
    :array_forming_error=>    'Ошибка формирования правового массива. Высока вероятность повреждения базы данных. Обратитесь к разработчику',
    :section_exists=>         'Раздел прав уже существует',
    :section_create=>         'Раздел прав создан',
    :section_rule_create=>    'Правило успешно создано и активировано',
    :section_rule_destroy=>   'Правило успешно удалено',
    :non_exists=>             'Раздел прав не существует',
    :try_to_create_section=>  'Попробуйте сперва создать раздел прав',
    :destroy_confirm=>        'Вы уверены что хотите удалить раздел прав со всеми вложенными правилами доступа: ',
    :have_no_policy=>         'Раздел не существует или не доступен'
  }
  
  # Messages::NestedSet[:element][:has_children]
  # Сообщения для работы с древовидной структурой acts_as_nested_set
  NestedSet={
    :element=>{
      :up=>'Узел дерева успешно перемещен вверх',
      :down=>'Узел дерева успешно перемещен вниз',
      :cant_be_move=>'Невозможно переместить узел',
      :deleted=>'Узел был удален',
      :has_children=>'Узел обладает дочерними элементами'
    }
  }
  
  # Messages::Pages[:updated]
  # Сообщения для работы со страницами
  Pages={
    :updated=>'Страница успешно обновлена',
    :created=>'Страница успешно создана'
  }
end