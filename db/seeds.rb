# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             user_name: "aaa",
             sex: 1,
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  user_name = Faker::Name.name
  password = "password"
  sex = 1
  User.create!(name:  name,
               email: email,
               user_name: user_name,
               sex: sex,
               password:              password,
               password_confirmation: password)
end