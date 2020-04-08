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
    puts "Error creating admin user: #{user.errors.full_messages.join(', ')}"
  end
else
  puts 'Skipping Admin User creation due to missing credentials in environment variables: ' \
    'ADMIN_EMAIL, ADMIN_PASSWORD'
end

TARGET_USER_COUNT = 10
EXISTING_USERS_COUNT = User.where(role: 'user').count
users_created_length = [TARGET_USER_COUNT, EXISTING_USERS_COUNT]
  .min
  .upto(TARGET_USER_COUNT - 1)
  .map { FactoryBot.create :user }
  .length
puts "Number of non-admin users created: #{users_created_length} (#{EXISTING_USERS_COUNT} was already present in DB)"
# rubocop:enable Rails/Output
