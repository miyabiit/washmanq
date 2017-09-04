require 'rails_helper'

describe CameraImageCollectRunner do
  describe "#run" do
    before do
      place = Place.create!(name: 'test')
      camera = Camera.create!(place: place, name: 'test')
      Dir.mkdir(Rails.root.join('tmp', 'cameras')) unless Dir.exist?(Rails.root.join('tmp', 'cameras'))
      Dir.mkdir(Rails.root.join('tmp', 'cameras', 'test')) unless Dir.exist?(Rails.root.join('tmp', 'cameras', 'test'))
      
      File.open(Rails.root.join('spec', 'data', 'cameras', 'test.jpg')) do |src_file|
        File.open(Rails.root.join('tmp', 'cameras', 'test', 'image20170101010101999.jpg'), 'w') do |dst_file|
          dst_file.write src_file.read
        end
      end
    end

    it do
      expect(File.exists?(Rails.root.join('tmp', 'cameras', 'test', 'image20170101010101999.jpg'))).to be_truthy
      expect(CameraImage.count).to eq(0)
      CameraImageCollectRunner.run
      expect(File.exists?(Rails.root.join('tmp', 'cameras', 'test', 'image20170101010101999.jpg'))).to be_falsy
      expect(CameraImage.count).to eq(1)
    end
  end
end
