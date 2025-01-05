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
end
