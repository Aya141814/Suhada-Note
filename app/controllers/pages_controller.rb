class PagesController < ApplicationController
  # ログイン不要にする
  skip_before_action :require_login

  def show
    # idパラメータのサニタイズと安全性チェック
    page = params[:id].to_s.strip

    # パストラバーサル対策（ディレクトリトラバーサルを防ぐ）
    if page.include?("..") || page.include?("/")
      raise ActionController::RoutingError.new("Not Found")
    end

    # 許可されたページリスト（必要に応じて拡張）
    allowed_pages = %w[terms]

    unless allowed_pages.include?(page)
      raise ActionController::RoutingError.new("Not Found")
    end

    # テンプレートのレンダリング
    render template: "pages/#{page}"
  end
end
