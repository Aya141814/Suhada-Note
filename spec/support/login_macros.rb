module LoginMacros
  def login_user(user)
    post login_path, params: { email: user.email, password: 'password' }
  end
end

RSpec.configure do |config|
  config.include LoginMacros
end
