class Like < ApplicationRecord
  belongs_to :user
  belongs_to :thing
  #Likeモデルに下のコードを書くと、Thingモデルのthingsテーブルのlikes_countカラムのカウンタキャッシュが最新に保たれる
  counter_culture :thing
  #user_idとthing_idが必須
  validates :user_id, presence: true
  validates :thing_id, presence: true
end
