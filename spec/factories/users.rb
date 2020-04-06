FactoryBot.define do
  factory :user do
    role { 'user' }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    full_name { Faker::Name.name }
    birth_date { Faker::Date.birthday min_age: 18, max_age: 100 }
    small_biography { Faker::Lorem.paragraph }

    trait :admin do
      role { 'admin' }
    end
    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/files/avatar.jpg'), 'image/jpg') }
    end
  end
end
