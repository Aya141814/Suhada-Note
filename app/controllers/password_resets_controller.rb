class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new; end

  def create
    @user = User.find_by(email: email_params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, success: t("defaults.message.sent_reset_password_instructions")
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = (password_params[:password_confirmation])
    if @user.change_password(password_params[:password])
      redirect_to login_path, success: "パスワードを変更できました"
    else
      flash.now[:danger] = "パスワード変更出来ませんでした"
      render :edit
    end
  end

  private

  def email_params
    params.permit(:email)
  end
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
