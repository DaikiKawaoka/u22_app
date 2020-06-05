class Thing < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  has_one_attached :thingImage

  validates :thingImage,   content_type: { in: %w[image/jpeg image/gif image/png image/jpg],
  message: "その画像は使用できません。" },
  size:         { less_than: 5.megabytes,
  message: "サイズが大きすぎます。" }

  # 表示用のりサイズ済み画像を返す
  def display_image
    thingImage.variant(resize_to_limit: [240, 240])
  end
end
