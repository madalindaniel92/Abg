namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Madalin Daniel",
                 email: "madalindaniel92@gmail.com",
                 password: "is needed",
                 password_confirmation: "is needed",
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "isneeded"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all.limit(6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.comments.create!(content: content) }
    end
  end      
end