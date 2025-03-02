class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :cheer_boards, through: :cheers, source: :board
  has_many :streaks, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end

  def cheer(board)
    cheer_boards << board
  end

  def uncheer(board)
    cheer_boards.destroy(board)
  end

  def cheer?(board)
    cheer_boards.include?(board)
  end

  def streak_for_category(category_name)
    streaks.find_or_create_by(category_name: category_name)
  end

  # 特定のカテゴリーの継続記録を取得
  def current_streak_for(category_name)
    streak = streak_for_category(category_name)
    {
      count: streak.display_streak,
      active: streak.active?,
      days_since_last: streak.days_since_last_post
    }
  end

  # ユーザーの表示名を返す
  def display_name
    "#{first_name} #{last_name}"
  end
end
