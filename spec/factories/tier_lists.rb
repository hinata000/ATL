FactoryBot.define do
  factory :tier_list do
    tier_score { 1 }
    spoiler { true }
    association :user
    association :animation
  end
end
