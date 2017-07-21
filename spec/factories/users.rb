FactoryGirl.define do
  factory :user do
    role 'user'
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    full_name { Faker::Name.name }
    birth_date { Faker::Date.birthday 18, 100 }
    small_biography { Faker::Lorem.paragraph }
    # avatar

    trait :admin { role 'admin' }
  end
end
