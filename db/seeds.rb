# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             user_name: "aaa",
             sex: 1,
             password:              "foobar",
             password_confirmation: "foobar")

User.create!(name:  "daiki",
             email: "kawadaiki@icloud.com",
             user_name: "daiki",
             sex: 1,
             password:              "daiki0807",
             password_confirmation: "daiki0807")

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

# ユーザーの一部を対象にマイクロポストを生成する
users = User.find_by(email:"kawadaiki@icloud.com")
thing_name = "机"
50.times do
  users.things.create!(thing_name:thing_name)
end