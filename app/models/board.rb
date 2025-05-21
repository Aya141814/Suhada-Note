class Board < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :board_skincare_items, dependent: :destroy
  has_many :skincare_items, through: :board_skincare_items
  has_many :board_skin_troubles, dependent: :destroy
  has_many :skin_troubles, through: :board_skin_troubles
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader
  after_create :trigger_for_streak


  private

  def trigger_for_streak
    # この投稿の作成日の開始時刻（その日の0時0分0秒）と終了時刻（その日の23時59分59秒）を取得
    day_start = self.created_at.beginning_of_day
    day_end = self.created_at.end_of_day

    is_first_board_on_day = !user.boards
        .where(created_at: day_start..day_end)
        .where("created_at < ?", self.created_at)
        .exists?

    if is_first_board_on_day
      streak = user.default_streak
      streak.update_streak
    end
      
  end
end
