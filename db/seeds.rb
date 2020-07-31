# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar", password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
10.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Word.create!(word: "test",
             meaning: "Kiem tra",
             pronounce: "/test/",
             word_type: "danh tu",
             image: "default_image.png")

users = User.all
word = Word.first
users[2..9].each { |user|
  user.learned_word(word)
}
Category.create!(name_category: "English")
Course.create!(course_name: "English Basic",
               category_id: 1,
               remote_image_url: "https://nguoikechuyen.net/wp-content/themes/fox/images/placeholder.jpg")
