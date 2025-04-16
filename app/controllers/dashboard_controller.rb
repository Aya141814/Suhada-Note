class DashboardController < ApplicationController
  def index
    # 過去30日間のスキンケア記録
    @recent_boards = current_user.boards.where(created_at: 30.days.ago..Time.current)
    
    # カレンダー用のすべての記録
    @boards = current_user.boards.includes(:skincare_items, :skin_troubles)
    
    # 継続率の計算（過去30日間で何日記録があるか）
    @completion_rate = (@recent_boards.pluck(:created_at).map(&:to_date).uniq.count / 30.0 * 100).round(1)
    
    # 現在のストリーク（連続何日記録しているか）
    @current_streak = current_user.default_streak.current_streak
    
    # Turboフレームからのリクエストの場合、カレンダー部分のみを返す
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
