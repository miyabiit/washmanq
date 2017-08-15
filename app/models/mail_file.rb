class MailFile < ApplicationRecord
  belongs_to :mail_info

  has_attached_file :file
  validates_attachment :file, less_than: 5.megabytes, content_type: {content_type: [%r{\Aapplication/.*\Z}, %r{\Aimage/.*\Z}, %r{\Atext/.*\Z}]}
end
