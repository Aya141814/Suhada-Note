require "test_helper"

class OauthsControllerTest < ActionDispatch::IntegrationTest
  test "should get oauth" do
    get auth_at_provider_path(provider: :google)
    assert_response :redirect
  end

  # OAuthのコールバックのテストはスキップします
  # 実際のOAuth認証フローをテストするには、モックやスタブが必要です
  test "should handle callback without code" do
    skip "このテストは実際のOAuth認証フローが必要なためスキップします"
    get oauth_callback_path(provider: :google)
    assert_response :redirect
    assert_redirected_to root_path
  end
end
