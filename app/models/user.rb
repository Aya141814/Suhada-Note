class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :cheer_boards, through: :cheers, source: :board
  has_many :streaks, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end

  def cheer(board)
    cheer_boards << board
  end

  def uncheer(board)
    cheer_boards.destroy(board)
  end

  def cheer?(board)
    cheer_boards.include?(board)
  end
# 特定のcartegoryを持つstreakを取得、または作成するメソッド（新しく作ったものは初期値が付与されるが、取得してきたものについては持っている値が保持される）
  def streak_for_category(category_name)
    streaks.find_or_create_by(category_name: category_name) do |streak|
      streak.current_streak = 0
      streak.end_date = nil
    end
  end
  # def current_streak
  #   streaks.order(created_at: :desc).first # 例えば最新のストリークを取得する
  # end

  # def update_streak
  #   # 現在の日付を取得する
  #   current_date = Date.current
    
  #   # ストリークを見つけるか、新しく作成する
  #   streak = streaks.find_or_create_by(streak_value: current_streak)  # categoryを削除
    
  #   # 最新の投稿日を取得する
  #   last_post_date = boards.maximum(:created_at)&.to_date # categoryを削除
    
  #   # ここにストリークを更新するためのロジックを追加することができる
  #   if last_post_date.nil?
  #     # カテゴリーの初めての投稿の場合、新しいstreakを作成
  #     streak.update(start_date: current_date, end_date: current_date, current_streak: 1)
  #   else
  #     day_diff = (current_date - last_post_date).to_i

  #     case day_diff
  #     when 0
  #       # 同日の投稿は無視（streakは更新しない）
  #     when 1
  #       # 連続投稿の場合、current_streakを増やし、end_dateを更新
  #       streak.update(
  #         end_date: current_date,
  #         current_streak: streak.current_streak + 1
  #       )
  #     else
  #       # 連続が途切れた場合、新しいstreakを開始
  #       streak.update(
  #         start_date: current_date,
  #         end_date: current_date,
  #         current_streak: 1
  #       )
  #     end
  #   end
  # end
end
