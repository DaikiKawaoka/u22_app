class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

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

  #いいね機能 ユーザが消えるといいねも消える
  has_many :likes, dependent: :destroy
  #keep機能　ユーザが消えるといいねも消える
  has_many :keeps, dependent: :destroy

  has_many :passive_relationships, class_name:  "Relationship",
  foreign_key: "followed_id",
  dependent:   :destroy#ユーザーを削除したら、ユーザーのリレーションシップも同時に削除される

  has_many :followers, through: :passive_relationships, source: :follower
#通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  has_many :comments, dependent: :destroy
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

  before_save { self.email = email.downcase }

  validates :name, presence: true,length: { minimum: 5, maximum: 30 }

  validates :user_name, presence: true,length: { minimum: 5, maximum: 30 },uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX }, uniqueness: true


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

  # # 渡されたトークンがダイジェストと一致したらtrueを返す
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # トークンがダイジェストと一致したらtrueを返す       抽象化されたauthenticated?メソッド
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

    # ユーザーをフォローする
    def follow(other_user)
      following << other_user
      #フォロー通知
      if other_user.user_notification
        Relationship.send_follow_email(other_user, self)
      end
    end

    # ユーザーをフォロー解除する
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
      #フォロー解除通知
      if other_user.user_notification
        Relationship.send_unfollow_email(other_user, self)
      end
    end

    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
      following.include?(other_user)
    end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 0.5.hours.ago
  end


  # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  #フォロー時の通知
 def create_notification_follow!(current_user)
  temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow',
        title: "フォローされました"
      )
      notification.save if notification.valid?
    end
  end

  private

    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
