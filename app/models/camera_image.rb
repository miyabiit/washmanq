class CameraImage < ApplicationRecord
  belongs_to :camera

  has_attached_file :image
  validates_attachment :image, less_than: 5.megabytes, content_type: {content_type: [%r{\Aimage/.*\Z}]}
end
