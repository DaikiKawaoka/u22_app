class Thing < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  has_one_attached :thingImage
  validates :thingImage,   content_type: { in: %w[image/jpeg image/gif image/png image/jpg],
  message: "その画像は使用できません。" },
  size:         { less_than: 5.megabytes,
  message: "サイズが大きすぎます。" }
  #通知機能
  has_many :notifications, dependent: :destroy

  validates :thing_name, presence: true,length: { maximum: 50 }
  validates :thing_comment,length: { maximum: 255 }
  validates :thing_type, presence: true
  validates :thing_assessment, presence: true

  # 表示用のりサイズ済み画像を返す
  def display_image
    thingImage.variant(resize_to_limit: [240, 240])
  end

  #タイプジャッジ
  def thing_type_judgment(thing)
  end
  #いいねアクション
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      thing_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

end
