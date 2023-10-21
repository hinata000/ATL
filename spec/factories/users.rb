FactoryBot.define do
  factory :user do
    email { |n| "user@example.com" }
    user_name { "user" }
    user_id { |n| "user" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
