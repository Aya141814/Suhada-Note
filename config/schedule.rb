# Use this file to easily define all of your cron jobs.
env :PATH, ENV['PATH']
# cronのパスを明示的に設定
env :GEM_PATH, ENV['GEM_PATH']
env :BUNDLE_PATH, ENV['BUNDLE_PATH']
env :RAILS_ENV, ENV['RAILS_ENV']

# ログ出力設定
set :output, {
  error: '/var/log/cron.error.log',
  standard: '/var/log/cron.log'
}

# テスト用に2分間隔で実行
every 2.minutes do
  rake "streaks:check_daily_status"
  # デバッグ用のecho
  command "echo 'Cron job executed at $(date)' >> /var/log/cron.log"
end 