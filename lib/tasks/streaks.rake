namespace :streaks do
  desc "Check daily status of all streaks"
  task check_daily_status: :environment do
    Rails.logger.info "Starting daily streak check at #{Time.current}"

    User.find_each do |user|
      user.streaks.find_each do |streak|
        if streak.days_since_last_post > 1
          Rails.logger.info "Resetting streak for user #{user.id} in category #{streak.category_name}"
          streak.update(current_streak: 0)
        end
      end
    end

    Rails.logger.info "Completed daily streak check at #{Time.current}"
  end
end 