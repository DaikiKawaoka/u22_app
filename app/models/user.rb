class User < ApplicationRecord

  has_many :active_relationships, class_name:  "Relationship",
  foreign_key: "follower_id",
  dependent:   :destroy #ユーザーを削除したら、ユーザーのリレーションシップも同時に削除される

  #:throughオプションは「Userモデルに割り付けられた、RelationshipモデルからUserモデルをどう参照するかの関係性」をシンボルで記述
  has_many :following, through: :active_relationships, source: :followed
  # 以下のような操作を行えるようになる

  # フォローしているユーザーの集合を調べる
  # 関連付けを通して、フォローしている特定のユーザーを検索する
  # 配列と同様にして、フォローしているユーザーを新規追加する
  # 特定のユーザーをフォローから削除する


  has_many :passive_relationships, class_name:  "Relationship",
  foreign_key: "followed_id",
  dependent:   :destroy#ユーザーを削除したら、ユーザーのリレーションシップも同時に削除される

  has_many :followers, through: :passive_relationships, source: :follower




  has_many :things
  has_one_attached :image

  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "その画像は使用できません。" },
                      size:         { less_than: 5.megabytes,
                                      message: "サイズが大きすぎます。" }

  # 表示用のりサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [240, 240])
  end

  def icon_image
    if self.sex == 1
      self.image.attach(io: File.open("#{Rails.root}/db/fixtures/icon_man.jpg"), filename: 'icon_man.jpg')
    elsif self.sex == 2
      self.image.attach(io: File.open("#{Rails.root}/db/fixtures/icon_woman.jpg"), filename: 'icon_woman.jpg')
    else
      self.image.attach(io: File.open("#{Rails.root}/db/fixtures/icon_other.jpg"), filename: 'icon_other.jpg')
    end
  end

  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  validates :name, presence: true,length: { minimum: 4, maximum: 20 }

  validates :user_name, presence: true,length: { minimum: 4, maximum: 20 },uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  # validates :user_image

  validates :user_comment,length: { maximum: 255 }

  validates :sex, presence: true

  has_secure_password
    #パスワードが空のままでも更新できるようにする
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)             #self.メソッド名はクラスメソッド(共有メソッド)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

    # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

      # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

    # ユーザーをフォローする
    def follow(other_user)
      following << other_user
    end

    # ユーザーをフォロー解除する
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
      following.include?(other_user)
    end
end
