require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_directory = ENV["AWS_BUCKET_NAME"] # S3バケット名を指定
    config.fog_credentials = {
      provider:              "AWS",
      aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"], # 環境変数から取得
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], # 環境変数から取得
      region:                "ap-southeast-2", # リージョンを指定
      path_style: true
    }
end
