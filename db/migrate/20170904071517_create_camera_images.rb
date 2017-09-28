class CreateCameraImages < ActiveRecord::Migration[5.1]
  def change
    create_table :camera_images do |t|
      t.references :camera, index: true, null: false, foreign_key: true
      t.datetime :shooted_at
      t.attachment :image

      t.timestamps
    end
  end
end
