class Thing < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  #default_scope -> { order(created_at: :desc) }
  has_one_attached :thingImage
  validates :thingImage,   content_type: { in: %w[image/jpeg image/gif image/png image/jpg],
  message: "その画像は使用できません。" },
  size:         { less_than: 5.megabytes,
  message: "サイズが大きすぎます。" }
  #通知機能
  has_many :notifications, dependent: :destroy

  #いいね機能　thingが消えるといいねも消える
  has_many :likes, dependent: :destroy
  #(thingにいいねをしたユーザーの一覧)
  has_many :iine_users, through: :likes, source: :user
  # 現在のユーザーがいいねしてたらtrueを返す
  def iine?(user)
    iine_users.include?(user)
  end

  #keep機能　thingが消えるとkeepも消える
  has_many :keeps, dependent: :destroy
  #userとkeepの中間テーブル作成　（thingにkeepした一覧）　
  has_many :keep_users, through: :keeps, source: :user
  # 現在のユーザーがkeepしてたらtrueを返す
  def keep?(user)
    keep_users.include?(user)
  end

  validates :thingImage, presence: true
  validates :thing_name, presence: true,length: { maximum: 50 }
  validates :thing_comment,length: { maximum: 255 }
  validates :thing_type, presence: true
  validates :thing_assessment, presence: true
  validates :thing_purchase_place, presence: true,length: { maximum: 30 }
  validates :thing_price, presence: true

  # 表示用のりサイズ済み画像を返す
  def display_image
    thingImage.variant(resize_to_fill: [240, 240])
  end
  def display_image_show
    thingImage.variant(resize_to_fill: [500, 500])
  end
  # thingImage.variant(resize_to_limit: [240, 240])  画像全体
  # thingImage.variant(resize_to_fill: [240, 240])  中心から正方形で切り取り
  # thingImage.variant(combine_options:{resize:"27x27^",crop:"27x27+0+0",gravity: :center}).processed 上から正方形で切り取り

  #いいねアクション
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      thing_id: id,
      visited_id: user_id,
      action: "like",
      title: "いいねが届きました"
    )
    notification.save if notification.valid?
  end
  #コメントアクション
  def create_notification_comment!(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Comment.select(:user_id).where(thing_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
          save_notification_comment!(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      #送った人と送られた人が同じだったら通知を作らない
      if current_user.id != visited_id
        notification = current_user.active_notifications.new(
          thing_id: id,
          comment_id: comment_id,
          visited_id: visited_id,
          action: 'comment',
          title: "コメントが届きました"
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
  end

  # thingをいいねする
  def iine(user)
    likes.create(user_id: user.id)
  end

  # thingのいいねを解除する
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  # thingをkeepする
  def keep(user)
    keeps.create(user_id: user.id)
  end

  # thingのkeepを解除する
  def unkeep(user)
    keeps.find_by(user_id: user.id).destroy
  end

end
