class SalesFile < ApplicationRecord
  paginates_per 20

  # TODO:
  has_attached_file :excel

  ## Validation
  validates_attachment :excel, less_than: 5.megabytes, content_type: {content_type: [%r{\Aapplication/.*\Z}]}
end
