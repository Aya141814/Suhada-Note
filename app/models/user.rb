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
  has_one :streak, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

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

  # ユーザーのデフォルトストリークを取得（または作成）
  def default_streak
    streak || create_streak
  end

  # 継続記録を取得
  def current_streak
    streak = default_streak
    {
      #三項演算子で「条件式 ? 真の場合の値 : 偽の場合の値」を返すもの
      count: streak.active? ? streak.display_streak : 0,
      active: streak.active?,
      days_since_last: streak.days_since_last_post
    }
  end

  # 後方互換性のために残しておく（deprecated）
  def streak_for_category(_category_name = nil)
    default_streak
  end

  # 後方互換性のために残しておく（deprecated）
  def current_streak_for(_category_name = nil)
    current_streak
  end

  # ユーザーの表示名を返す
  def display_name
    "#{first_name} #{last_name}"
  end
end
