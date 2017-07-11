s3_credentials = {
  bucket: ENV['S3_BUCKET_NAME'],
  access_key_id: ENV['AWS_ACCESS_KEY'],
  secret_access_key: ENV['AWS_SECRET_KEY']
}
if s3_credentials.values.all?(&:present?)
  Paperclip::Attachment.default_options.merge!(
    storage: :s3,
    s3_credentials: s3_credentials,
    s3_protocol: '',
    s3_region: ENV['S3_REGION'],
    url: ':s3_domain_url',
    path: '/:class/:attachment/:hash/:style/:filename',
    hash_secret: 'washmanq'
  )
end
