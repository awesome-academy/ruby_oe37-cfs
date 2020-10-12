User.create!(full_name: "Admin User",
            email:"admin@gmail.com",
            password: "123456",
            password_confirmation: "123456",
            role: true,
            activated: true,
            activated_at: DateTime.now)

20.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "123456"
  User.create!(full_name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: DateTime.now)
end

users = User.order(:created_at).take(6)
10.times do
name = Faker::Lorem.sentence(word_count: 5)
users.each { |user| user.categories.create!(name: name) }
end
