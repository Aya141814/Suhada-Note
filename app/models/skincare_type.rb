class SkincareType < ApplicationRecord
  has_many :post_skincare_types
  has_many :boards, through: :post_skincare_types
end
