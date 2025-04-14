# app/controllers/trophies_controller.rb
class TrophiesController < ApplicationController
  def index
    @trophies = current_user.trophies.order('user_trophies.achieved_at DESC')
  end
end