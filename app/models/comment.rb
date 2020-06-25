class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :thing
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }
end
