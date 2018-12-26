if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => 'AKIAJUUAETCYVMH2532A',
      :aws_secret_access_key => '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'
    }
    config.fog_directory     =  'arn:aws:s3:::sampapp-bucket'
  end
end
