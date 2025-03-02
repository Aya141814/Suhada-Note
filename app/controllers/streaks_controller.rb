class StreaksController < ApplicationController
  def show
    @streak = current_user.streak_for_category("スキンケア")
    @recent_posts = current_user.boards
                              .where(category_name: "スキンケア")
                              .order(created_at: :desc)
                              .limit(5)
  end
end