class StreaksController < ApplicationController
  def show
    category_name = params[:category_name]
    @streak = current_user.streak_for_category(category_name)
    @streak.reset_if_broken if @streak.present?
  end
end