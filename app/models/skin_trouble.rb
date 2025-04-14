class SkinTrouble < ApplicationRecord
  has_many :board_skin_troubles, dependent: :destroy
  has_many :boards, through: :board_skin_troubles

  validates :name, presence: true, uniqueness: true
end
