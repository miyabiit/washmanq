class CameraImageCollectRunner
  def self.run
    base_path = Rails.application.config.camera_image_collect['path']
    
    Camera.all.each do |camera|
      Dir[File.join(base_path, camera.name, '*')].each do |file_name|
        shooted_at = Time.strptime(File.basename(file_name).scan(/\d{17,17}/).first, '%Y%m%d%H%M%S%L')
        unless camera.camera_images.where(shooted_at: shooted_at).exists?
          File.open(file_name) do |file|
            camera_image = CameraImage.create!(
              camera: camera,
              shooted_at: shooted_at,
              image: file
            )
            CameraChannel.broadcast_to_camera camera
          end
        end
        File.delete(file_name)
      end
    end 
  end
end
