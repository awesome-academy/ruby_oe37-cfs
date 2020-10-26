FactoryBot.define do
  factory :plan do
    month {rand(1..12)}
    spending_category {["income", "expenses"].sample}
    type_money {["fixed", "incurred"].sample}
    status {["confirm", "unconfirm"].sample}
    moneys {rand(1000..10000)}
    association :user
    association :category
  end
end
