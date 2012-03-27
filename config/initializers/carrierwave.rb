# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',       # required
#     :aws_access_key_id      => 'AKIAIB2FFRWPFBNGDGYQ',       # required
#     :aws_secret_access_key  => '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',       # required
#     :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
#   }
#   config.fog_directory  = 'ksimages'                     # required
#   config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
#   config.fog_public     = false                                   # optional, defaults to true
#   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
# end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => 'GOOGDWIDX3IR4K65KSUJ',
    :google_storage_secret_access_key => '5sryhX6/PRVFvwd8huXeeBUnx6Tyw/wqXlJzChIS'
  }
  config.fog_directory = 'kimages'
end