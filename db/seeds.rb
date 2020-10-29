User.create!(full_name: "Admin",
            email:"admin@gmail.com",
            password: "123456",
            password_confirmation: "123456",
            role: 0,
            confirmed_at: DateTime.now)
User.create!(full_name: "member",
            email:"member@gmail.com",
            password: "123456",
            password_confirmation: "123456",
            role: 2,
            confirmed_at: DateTime.now)

10.times do |n|
  User.create!(full_name: Faker::FunnyName.name,
              email: "user#{n+1}@gmail.com",
              password: "123456",
              password_confirmation: "123456",
              confirmed_at: DateTime.now)
end

users = User.order(:created_at).take(6)
10.times do
  name = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.categories.create!(name: name) }
end

500.times do

  Plan.create!(
    month: rand(1..12),
    category_id: rand(1..5),
    spending_category: rand(0..1),
    type_money: rand(0..1),
    status: rand(0..1),
    moneys: rand(1000..10000),
    user_id: rand(1..10))
end
