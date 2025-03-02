class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :category_name, presence: true

  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader

  after_create :update_streak

  private

  def update_streak
    streak = user.streak_for_category(category_name)
    streak.record_activity
  end
end
