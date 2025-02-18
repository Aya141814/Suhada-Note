class Streak < ApplicationRecord
  belongs_to :user
  validates :category_name, presence: true, uniqueness: { scope: :user_id }

  # 継続が途切れている場合にリセットするメソッド
  def reset_if_broken
    if last_post_date.nil? || last_post_date < Date.yesterday
      update(current_streak: 0)
    end
  end
end
