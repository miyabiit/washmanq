class CreateCameras < ActiveRecord::Migration[5.1]
  def change
    create_table :cameras do |t|
      t.references :place, index: true, null: false, foreign_key: true
      t.string :name
      t.string :display_name
      t.string :mft_code

      t.timestamps
    end
  end
end
