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
  puts 'Skipping Admin User creation due to missing credentials in environment variables: ADMIN_EMAIL, ADMIN_PASSWORD'
end

TARGET_USER_COUNT = 10
users_created_length = [TARGET_USER_COUNT, User.where(role: 'user').count]
  .min
  .upto(TARGET_USER_COUNT - 1)
  .map { FactoryBot.create :user }
  .length
puts "Number of users created: #{users_created_length}"
