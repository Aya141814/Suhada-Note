class Board < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :board_skincare_items, dependent: :destroy
  has_many :skincare_items, through: :board_skincare_items
  has_many :board_skin_troubles, dependent: :destroy
  has_many :skin_troubles, through: :board_skin_troubles
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader
  after_create :update_streak

  private

  def update_streak
    streak = user.default_streak
    streak.record_activity
  end
end
