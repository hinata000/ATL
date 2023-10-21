FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    user_name { "user" }
    user_id { "user" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
