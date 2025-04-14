class BoardSkincareItem < ApplicationRecord
  belongs_to :board
  belongs_to :skincare_item
end
