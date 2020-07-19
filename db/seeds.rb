# メインのサンプルユーザーを1人作成する
User.create!(name:  "Guest User",
             email: "example@u22app.jp",
             user_name: "guest_user",
             sex: 1,
             password:              "albieajasnofmg904bwjepjapew39026849isy",
             password_confirmation: "albieajasnofmg904bwjepjapew39026849isy",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "daiki",
             email: "kawadaiki@icloud.com",
             user_name: "daiki",
             sex: 1,
             password:              "daiki0000",
             password_confirmation: "daiki0000",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "keita",
             email: "kbc19a17@stu.kawahara.ac.jp",
             user_name: "keita",
             sex: 1,
             password:              "keita1106",
             password_confirmation: "keita1106",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "junia",
             email: "kbc19a21@stu.kawahara.ac.jp",
             user_name: "junia",
             sex: 1,
             password:              "junia0000",
             password_confirmation: "junia0000",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "okityan",
             email: "kbc19a7@stu.kawahara.ac.jp",
             user_name: "okityan",
             sex: 1,
             password:              "okityan0000",
             password_confirmation: "okityan0000",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "seiitirou",
             email: "kbc19a24@stu.kawahara.ac.jp",
             user_name: "seiitirou",
             sex: 1,
             password:              "seiitirou0000",
             password_confirmation: "seiitirou0000",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "bezi-ta",
             email: "kbc19a25@stu.kawahara.ac.jp",
             user_name: "bezi-ta",
             sex: 1,
             password:              "bezi-ta0000",
             password_confirmation: "bezi-ta0000",
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
60.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  sex = 1
  user=User.create!(name:  name,
               email: email,
               user_name: name,
               sex: sex,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  user.icon_image
end

User.create!(name:  "daikon",
  email: "kbc19a11@stu.kawahara.ac.jp",
  user_name: "daikon",
  sex: 3,
  password:              "daikon0000",
  password_confirmation: "daikon0000",
  activated: true,
  activated_at: Time.zone.now)


# 以下のリレーションシップを作成する
usersall = User.all

# ユーザーの一部を対象にthingを生成する
users = User.find_by(email:"example@u22app.jp")
users.image.attach(io: File.open("#{Rails.root}/db/fixtures/f1.png"), filename: 'f1.png')

users = User.find_by(email:"kawadaiki@icloud.com")
users.icon_image
following = usersall[0..50]
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"java2の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
)
thing = Thing.find_by(thing_name:"java2の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5621.jpg"), filename: 'IMG_5621.jpg')

users.things.create!(
  thing_name:"SQLの本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"SQLの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5622.jpg"), filename: 'IMG_5622.jpg')

users.things.create!(
  thing_name:"応用情報対策の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"応用情報対策の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5623.jpg"), filename: 'IMG_5623.jpg')

users = User.find_by(email:"kbc19a17@stu.kawahara.ac.jp")
users.icon_image
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"基本情報の本『kitamisiki』",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"基本情報の本『kitamisiki』")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5624.jpg"), filename: 'IMG_5624.jpg')

users.things.create!(
  thing_name:"応用情報の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"応用情報の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5625.jpg"), filename: 'IMG_5625.jpg')

users.things.create!(
  thing_name:"応用情報午後の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"応用情報午後の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5626.jpg"), filename: 'IMG_5626.jpg')


users = User.find_by(email:"kbc19a21@stu.kawahara.ac.jp")
users.icon_image
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"Java1の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"Java1の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5627.jpg"), filename: 'IMG_5627.jpg')

users.things.create!(
  thing_name:"応用情報テキスト",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"応用情報テキスト")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5628.jpg"), filename: 'IMG_5628.jpg')

users.things.create!(
  thing_name:"HTML,CSSの本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"HTML,CSSの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5629.jpg"), filename: 'IMG_5629.jpg')


users = User.find_by(email:"kbc19a7@stu.kawahara.ac.jp")
users.icon_image
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"Ruby on Rails の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"Ruby on Rails の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5630.jpg"), filename: 'IMG_5630.jpg')

users.things.create!(
  thing_name:"Androidアプリ開発",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"Androidアプリ開発")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5631.jpg"), filename: 'IMG_5631.jpg')

users.things.create!(
  thing_name:"面接、ビジネスマナーの本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"面接、ビジネスマナーの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5632.jpg"), filename: 'IMG_5632.jpg')


users = User.find_by(email:"kbc19a24@stu.kawahara.ac.jp")
users.icon_image
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"Linuxの本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"Linuxの本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5633.jpg"), filename: 'IMG_5633.jpg')

users.things.create!(
  thing_name:"JavaScript の本",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"JavaScript の本")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5634.jpg"), filename: 'IMG_5634.jpg')

users.things.create!(
  thing_name:"Linuxのコマンド ",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )
thing = Thing.find_by(thing_name:"Linuxのコマンド ")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5636.jpg"), filename: 'IMG_5636.jpg')


users = User.find_by(email:"kbc19a25@stu.kawahara.ac.jp")
users.icon_image
following.each { |followed| users.follow(followed) }
users.things.create!(
  thing_name:"アルゴリズムのテキスト",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )

thing = Thing.find_by(thing_name:"アルゴリズムのテキスト")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5637.jpg"), filename: 'IMG_5637.jpg')

users.things.create!(
  thing_name:"文章力のテキスト",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )

thing = Thing.find_by(thing_name:"文章力のテキスト")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5638.jpg"), filename: 'IMG_5638.jpg')

users.things.create!(
  thing_name:"ネットワークの本 ",
  thing_comment:"とてもいい",
  thing_type: 2,
  thing_assessment: 5,
  thing_shear: true,
  )

thing = Thing.find_by(thing_name:"ネットワークの本 ")
thing.thingImage.attach(io: File.open("#{Rails.root}/db/fixtures/IMG_5640.jpg"), filename: 'IMG_5640.jpg')
