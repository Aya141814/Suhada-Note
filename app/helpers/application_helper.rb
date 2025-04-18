module ApplicationHelper
  def page_title(title = "")
    base_title = "Suhada Note"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
  def default_meta_tags
  {
    site: "Suhada Note",
    title: "スキンケアの記録、継続を目指すサービス",
    reverse: true,
    charset: "utf-8",
    description: "Suhada Noteでは、スキンケアの記録を残し、ユーザー同士で応援し合うことでスキンケアの継続を習慣化を達成するためのサービスです。",
    keywords: "スキンケア,美容,健康,継続,応援,共有",
    canonical: request.original_url,
    separator: "|",
    og: {
      site_name: "Suhada Note",  # 文字列として指定
      title: "スキンケアの記録、継続を目指すサービス",  # 文字列として指定
      description: "Suhada Noteでは、スキンケアの記録を残し、ユーザー同士で応援し合うことでスキンケアの継続を習慣化を達成するためのサービスです",  # 文字列として指定
      type: "website",
      url: request.original_url,
      image: image_url("ogp.png"),
      locale: "ja-JP"  # 修正
    },
    twitter: {
      card: "summary_large_image",
      site: "@Aya12669607",
      image: image_url("ogp.png")
    }
  }
  end

  private

  def base_url
    if Rails.env.production?
      "https://#{request.host}"  # 本番環境では実際のホスト名を使用
    else
      "#{request.protocol}#{request.host_with_port}"  # 開発環境では現在のホスト名とポートを使用
    end
  end
end
