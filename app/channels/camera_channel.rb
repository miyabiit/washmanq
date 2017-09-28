class CameraChannel < ApplicationCable::Channel
  def subscribed
    camera = Camera.find(params[:id])
    stream_for camera
    CameraChannel.broadcast_to_camera camera
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.broadcast_to_camera(camera)
    self.broadcast_to camera, {imageUrl: camera.last_image&.image&.url, shootedAt: camera.last_image&.shooted_at&.strftime('%Y-%m-%d %H:%M:%S')}
  end
end
