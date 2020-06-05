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

User.create!(name:  "けいた",
             email: "keita@icloud.com",
             user_name: "keita",
             sex: 1,
             password:              "keita0000",
             password_confirmation: "keita0000")

User.create!(name:  "ジュニア",
             email: "zyunia@icloud.com",
             user_name: "zyunia",
             sex: 1,
             password:              "zyunia0000",
             password_confirmation: "zyunia0000")

User.create!(name:  "沖ちゃん",
             email: "okityan@icloud.com",
             user_name: "okityan",
             sex: 1,
             password:              "okityan0000",
             password_confirmation: "okityan0000")

User.create!(name:  "誠一郎",
             email: "seiitirou@icloud.com",
             user_name: "seiitirou",
             sex: 1,
             password:              "seiitirou0000",
             password_confirmation: "seiitirou0000")

User.create!(name:  "ベジータ",
             email: "bezi-ta@icloud.com",
             user_name: "bezi-ta",
             sex: 1,
             password:              "bezi-ta0000",
             password_confirmation: "bezi-ta0000")

# 追加のユーザーをまとめて生成する
60.times do |n|
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

# 以下のリレーションシップを作成する
usersall = User.all

# ユーザーの一部を対象にthingを生成する
users = User.find_by(email:"kawadaiki@icloud.com")
following = usersall[0..50]
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"java2の本",
  thing_comment:"とてもいい",
)
thing = Thing.find_by(thing_name:"java2の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5621.jpg"), filename: 'IMG_5621.jpg')

users.things.create!(
  thing_name:"SQLの本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"SQLの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5622.jpg"), filename: 'IMG_5622.jpg')

users.things.create!(
  thing_name:"応用情報対策の本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"応用情報対策の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5623.jpg"), filename: 'IMG_5623.jpg')

users = User.find_by(email:"keita@icloud.com")
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"基本情報の本『kitamisiki』",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"基本情報の本『kitamisiki』")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5624.jpg"), filename: 'IMG_5624.jpg')

users.things.create!(
  thing_name:"応用情報の本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"応用情報の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5625.jpg"), filename: 'IMG_5625.jpg')

users.things.create!(
  thing_name:"応用情報午後の本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"応用情報午後の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5626.jpg"), filename: 'IMG_5626.jpg')


users = User.find_by(email:"zyunia@icloud.com")
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"Java1の本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"Java1の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5627.jpg"), filename: 'IMG_5627.jpg')

users.things.create!(
  thing_name:"応用情報テキスト",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"応用情報テキスト")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5628.jpg"), filename: 'IMG_5628.jpg')

users.things.create!(
  thing_name:"HTML,CSSの本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"HTML,CSSの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5629.jpg"), filename: 'IMG_5629.jpg')


users = User.find_by(email:"okityan@icloud.com")
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"Ruby on Rails の本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"Ruby on Rails の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5630.jpg"), filename: 'IMG_5630.jpg')

users.things.create!(
  thing_name:"Androidアプリ開発",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"Androidアプリ開発")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5631.jpg"), filename: 'IMG_5631.jpg')

users.things.create!(
  thing_name:"面接、ビジネスマナーの本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"面接、ビジネスマナーの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5632.jpg"), filename: 'IMG_5632.jpg')


users = User.find_by(email:"seiitirou@icloud.com")
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"Linuxの本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"Linuxの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5633.jpg"), filename: 'IMG_5633.jpg')

users.things.create!(
  thing_name:"JavaScript の本",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"JavaScript の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5634.jpg"), filename: 'IMG_5634.jpg')

users.things.create!(
  thing_name:"Linuxのコマンド ",
  thing_comment:"とてもいい",
  )
thing = Thing.find_by(thing_name:"Linuxのコマンド ")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5636.jpg"), filename: 'IMG_5636.jpg')


users = User.find_by(email:"bezi-ta@icloud.com")
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"アルゴリズムのテキスト",
  thing_comment:"とてもいい",
  )

thing = Thing.find_by(thing_name:"アルゴリズムのテキスト")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5637.jpg"), filename: 'IMG_5637.jpg')

users.things.create!(
  thing_name:"文章力のテキスト",
  thing_comment:"とてもいい",
  )

thing = Thing.find_by(thing_name:"文章力のテキスト")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5638.jpg"), filename: 'IMG_5638.jpg')

users.things.create!(
  thing_name:"ネットワークの本 ",
  thing_comment:"とてもいい",
  )

thing = Thing.find_by(thing_name:"ネットワークの本 ")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5640.jpg"), filename: 'IMG_5640.jpg')
