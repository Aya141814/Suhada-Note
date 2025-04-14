class Trophy < ApplicationRecord
  validates :name, presence: true
  validates :trophy_type, presence: true
  validates :requirement, presence: true, numericality: { greater_than: 0 }
  
  has_many :user_trophies
  has_many :users, through: :user_trophies
  
  # トロフィータイプに基づいて条件をチェックするメソッド（現在はストリークのみ）
  def check_achievement(user)
    case trophy_type
    when "streak"
      user_streak = user.default_streak.current_streak
      user_streak >= requirement
    else
      false
    end
  end

  def self.recently_awarded_for(user, since = 10.seconds.ago)
    joins(:user_trophies)
      .where(user_trophies: { user_id: user.id })
      .where('user_trophies.achieved_at > ?', since)
      .distinct
  end
end
