# FIXME: Store email and password in settings
EMAIL = 'astyagun@gmail.com'
PASSWORD = '123123123'
User.create(
  role:                  'admin',
  email:                 EMAIL,
  password:              PASSWORD,
  password_confirmation: PASSWORD,
  full_name:             'Admin User',
  birth_date:            Time.zone.today,
  small_biography:       'Жили были... умерли бумерли'
)
