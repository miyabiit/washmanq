class AddEquipmentCountToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :equipment_count, :integer
  end
end
