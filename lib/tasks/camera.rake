namespace :camera do
  desc 'make dummy images'
  task :make_dummy => :environment do

    time_now = Time.now
    file_name = "image#{time_now.strftime('%Y%m%d%H%M%S%L')}.jpg"
    base_path = Rails.application.config.camera_image_collect['path']
    Dir.mkdir(base_path) unless Dir.exist?(base_path)

    Camera.all.each do |camera|
      Dir.mkdir(File.join(base_path, camera.name)) unless Dir.exist?(File.join(base_path, camera.name))

      image = Magick::Image.new(640, 480) do
        self.background_color = "gray" 
      end

      draw = Magick::Draw.new
      draw.annotate(image, 100, 100, 100, 100, "#{camera.name}: #{time_now.strftime('%Y/%m/%d %H:%M:%S')}") do
        self.fill = 'black'
        self.align = Magick::LeftAlign 
        self.stroke = 'transparent'
        self.pointsize = 30
        self.text_antialias = true
        self.kerning = 1
      end

      image.write(File.join(base_path, camera.name, file_name).to_s)
      image.destroy!
    end
  end
end
