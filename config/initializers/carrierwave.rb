CarrierWave.configure do |config|

  if Rails.env.development?
    S3_BUCKET = "testczarianoi"
    S3_KEY = "AKIAJ3XOHNS4GIDGARQ"
    S3_SECRET = "eYQVd+jtUhngoRjt8e1AkK1MITi4VfE/JOMVs/HN"
    S3_REGION = "eu-central-1"
  end
  config.fog_credentials = {

      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => ENV['S3_REGION'] # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = ENV['S3_BUCKET']

  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end
end

