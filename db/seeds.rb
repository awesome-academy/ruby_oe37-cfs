User.create!(full_name: "admin",
            email:"admin@cashflow.com",
            password: "123456",
            password_confirmation: "123456",
            role: true,
            activated: true,
            activated_at: DateTime.now)
99.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "123456"
  User.create!(full_name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: DateTime.now)
end
