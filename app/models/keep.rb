class Keep < ApplicationRecord
  belongs_to :user
  belongs_to :thing
  validates :user_id, presence: true
  validates :thing_id, presence: true
end
