class SkincareItem < ApplicationRecord
  has_many :board_skincare_items
  has_many :boards, through: :board_skincare_items

  validates :name, presence: true, uniqueness: true
end
