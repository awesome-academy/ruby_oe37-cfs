User.create!(full_name: "Example User",
            email:"example@railstutorial.org",
            password: "12345",
            password_confirmation: "12345",
            role: true,
            activated: true,
            activated_at: DateTime.now)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(full_name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: DateTime.now)
end

users = User.order(:created_at).take(6)
150.times do
name = Faker::Lorem.sentence(word_count: 5)
users.each { |user| user.categories.create!(name: name) }
end
