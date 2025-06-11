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
    Rails.logger.info "=== STREAK DEBUG: trigger_for_streak called ==="
    Rails.logger.info "Board ID: #{self.id}, User ID: #{self.user_id}"
    Rails.logger.info "created_at: #{self.created_at}, to_date: #{self.created_at.to_date}"
    Rails.logger.info "Time.zone: #{Time.zone}, Date.today: #{Date.today}"
    
    # この投稿の作成日の開始時刻（その日の0時0分0秒）と終了時刻（その日の23時59分59秒）を取得
    day_start = self.created_at.beginning_of_day
    Rails.logger.info "day_start: #{day_start}"

    is_first_board_on_day = !user.boards
      .where(created_at: day_start...self.created_at)  # その日の0:00〜現在の投稿時刻（排他）
      .exists?

    Rails.logger.info "is_first_board_on_day: #{is_first_board_on_day}"

    if is_first_board_on_day
      Rails.logger.info "=== STREAK UPDATE: Attempting to update streak ==="
      streak = user.default_streak
      Rails.logger.info "Streak ID: #{streak.id}, current_streak: #{streak.current_streak}"
      Rails.logger.info "Streak start_date: #{streak.start_date}, end_date: #{streak.end_date}"
      
      begin
        date_to_use = self.created_at.to_date
        Rails.logger.info "date_to_use for streak update: #{date_to_use}"
        streak.update_streak(date_to_use)
        Rails.logger.info "=== STREAK UPDATE: Successfully updated ==="
      rescue => e
        Rails.logger.error "=== STREAK UPDATE ERROR: #{e.message} ==="
        Rails.logger.error e.backtrace.join("\n")
      end
    else
      Rails.logger.info "=== STREAK: Skipped - not first board of the day ==="
    end
  end
end
