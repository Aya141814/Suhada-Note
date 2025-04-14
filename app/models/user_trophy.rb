class UserTrophy < ApplicationRecord
  belongs_to :user
  belongs_to :trophy

  validates :achieved_at, presence: true
  validates :trophy_id, uniqueness: { scope: :user_id }
end
