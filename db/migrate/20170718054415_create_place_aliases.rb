class CreatePlaceAliases < ActiveRecord::Migration[5.1]
  def change
    create_table :place_aliases do |t|
      t.references :place, index: true, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :place_aliases, :name, unique: true
  end
end
