# rubocop:disable Rails/Output
if ENV['ADMIN_EMAIL'].present? && ENV['ADMIN_PASSWORD'].present?
  user = User.create(
    role:                  'admin',
    email:                 ENV['ADMIN_EMAIL'],
    password:              ENV['ADMIN_PASSWORD'],
    password_confirmation: ENV['ADMIN_PASSWORD'],
    full_name:             'Admin User',
    birth_date:            Time.zone.today,
    small_biography:       'Was created to do good'
  )

  if user.save
    puts 'Admin User created successfully'
  else
    puts user.errors.full_messages.join(', ')
  end
else
  puts 'Skipping Admin User creation due to missing credentials'
end
