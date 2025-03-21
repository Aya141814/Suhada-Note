class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :category_name, presence: true

  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader

  # スキンケアアイテムを配列として扱う
  serialize :skincare_items, coder: YAML
  after_initialize :set_default_skincare_items, if: :new_record?

  after_create :update_streak

  private

  def update_streak
    streak = user.streak_for_category(category_name)
    streak.record_activity
  end

  def set_default_skincare_items
    self.skincare_items ||= []
  end
end
