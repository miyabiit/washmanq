class AddIndexToCameraImages < ActiveRecord::Migration[5.1]
  def change
    add_index :camera_images, :shooted_at
  end
end
