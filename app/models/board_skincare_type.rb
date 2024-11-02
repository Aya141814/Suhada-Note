class BoardSkincareType < ApplicationRecord
  belongs_to :board
  belongs_to :skincare_type
end
