class MailInfo < ApplicationRecord
  paginates_per 10

  validates :title, :from, length: {maximum: 100}
  has_many :mail_files, dependent: :destroy
end
