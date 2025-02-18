class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :category_name, presence: true

  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  belongs_to :user
  mount_uploader :board_image, BoardImageUploader
# 投稿作成時に、streakを更新する
  after_create :update_streak

  def update_streak
    # カテゴリーに対応するStreakを取得または作成
    streak = user.streak_for_category(category_name)
    today = Date.today
# ↑のstreak_for_categoryはuserモデルで定義しているもの
    if streak.end_date.nil? || streak.end_date < today
      # 初めての投稿か、前回の投稿日が昨日以前の場合
      if streak.end_date == today - 1.day
      # 最終投稿日が昨日の場合（連続して投稿ができている場合）
        streak.current_streak += 1
      else
        # それ以外（連続していない場合）は連続日数が１にリセットされる
        streak.current_streak = 1
      end
      # 最後の投稿日を今日に設定して保存
      streak.end_date = Date.today
      streak.save
    end
  end
end
