FactoryBot.define do
  factory :bookmark do
    association :user
    association :animation
  end
end
