module ApplicationHelper
  def page_title(title = "")
    base_title = "Skin Care Cheer"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
  def default_meta_tags
  {
    site: "Skin Care Cheer",
    title: "スキンケアの記録、継続を目指すサービス",
    reverse: true,
    charset: "utf-8",
    description: "Skin Care Cheerでは、スキンケアの記録を残し、ユーザー同士で応援し合うことでスキンケアの継続を習慣化を達成するためのサービスです。",
    keywords: "スキンケア,美容,健康,継続,応援,共有",
    canonical: request.original_url,
    separator: "|",
    og: {
      site_name: "Skin Care Cheer",  # 文字列として指定
      title: "スキンケアの記録、継続を目指すサービス",  # 文字列として指定
      description: "Skin Care Cheerでは、スキンケアの記録を残し、ユーザー同士で応援し合うことでスキンケアの継続を習慣化を達成するためのサービスです",  # 文字列として指定
      type: "website",
      url: request.original_url,
      image: image_url("ogp.png"),
      locale: "ja-JP"  # 修正
    },
    twitter: {
      card: "summary_large_image",
      site: "@obvyamdrss",
      image: image_url("ogp.png")
    }
  }
  end
end
