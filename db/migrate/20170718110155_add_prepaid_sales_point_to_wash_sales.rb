class AddPrepaidSalesPointToWashSales < ActiveRecord::Migration[5.1]
  def change
    add_column :wash_sales, :prepaid_sales_point, :integer
  end
end
