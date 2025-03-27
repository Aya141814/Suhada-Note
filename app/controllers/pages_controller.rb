class PagesController < ApplicationController
  # ログイン不要にする
  skip_before_action :require_login

  def show
    # High-Voltageスタイルでpages/以下のテンプレートをレンダリング
    render template: "pages/#{params[:id]}"
  end
end 