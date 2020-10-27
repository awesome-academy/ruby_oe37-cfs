FactoryBot.define do
  factory :share do
    month {rand(1..12)}
    association :from_user, class_name: "User"
    association :to_user, class_name: "User"
  end
end
