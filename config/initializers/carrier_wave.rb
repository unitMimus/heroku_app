if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => 'AKIAJUUAETCYVMH2532A',
      :aws_secret_access_key => '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'
    }
<<<<<<< HEAD
    config.fog_directory     =  'aws:s3:::sampapp-bucket'
=======
    config.fog_directory     =  'arn:aws:s3:::sampapp-bucket'
>>>>>>> bb2a3434ab6625d155d0e0f733867466ab516a0d
  end
end
