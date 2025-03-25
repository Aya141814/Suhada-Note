class StreaksController < ApplicationController
  def show
    @streak = current_user.default_streak
    @recent_posts = current_user.boards
                              .order(created_at: :desc)
                              .limit(5)
  end
end
