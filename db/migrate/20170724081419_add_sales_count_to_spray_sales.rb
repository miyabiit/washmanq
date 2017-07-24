class AddSalesCountToSpraySales < ActiveRecord::Migration[5.1]
  def change
    add_column :spray_sales, :sales_count, :integer
  end
end
