class Streak < ApplicationRecord
  belongs_to :user
  validates :current_streak, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # デフォルト値の設定
  after_initialize :set_default_values, if: :new_record?
  # saved_change_to_current_streakはDirtyAPIの一部で、その属性が保存操作で変更されたかどうかを確認している
  after_save :check_trophies, if: :saved_change_to_current_streak?

  # 継続記録を更新するメソッド（boardモデルから呼び出される）
  def update_streak(date = Date.today)
    if continuing_streak?(date)
      increment_streak(date)
    else
      reset_streak(date)
    end
  end

  # ⭐️streakのビュー関連メソッドここから⭐️
  # 最終投稿日からの経過日数を計算
  def days_since_last_post
    return nil if end_date.nil?
    (Date.current - end_date).to_i
  end

  # 継続中かどうかを判定
  def active?
    return false if end_date.nil?
    (Date.current - end_date).to_i <= 1
  end
  # ⭐️ここまで⭐️
  
  private
  def set_default_values
    self.current_streak ||= 0
    self.start_date ||= nil
    self.end_date ||= nil
  end

  def continuing_streak?(date)
    end_date.present? && end_date == date - 1.day
  end

  def increment_streak(date)
    self.current_streak += 1
    self.end_date = date
    save
  end

  def reset_streak(date)
    self.current_streak = 1
    self.start_date = date
    self.end_date = date
    save
  end

  def check_trophies
    user.check_and_award_trophies
  end
end
