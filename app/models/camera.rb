class Camera < ApplicationRecord
  belongs_to :place
  has_many :camera_images

  def last_image
    camera_images.order(shooted_at: :desc).first
  end
end
