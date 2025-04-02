ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

# OAuthテスト用のヘルパーメソッドを追加
class ActionDispatch::IntegrationTest
  # テスト用にログインを模倣するヘルパーメソッド
  def login_user(user)
    post login_path, params: { email: user.email, password: "password123" }
  end
end
