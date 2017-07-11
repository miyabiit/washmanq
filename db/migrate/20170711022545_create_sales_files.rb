class CreateSalesFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_files do |t|
      t.attachment :excel
      t.timestamps
    end
  end
end
