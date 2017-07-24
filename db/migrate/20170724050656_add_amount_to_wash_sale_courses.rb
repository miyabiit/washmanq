class AddAmountToWashSaleCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :wash_sale_courses, :cash_sales_amount, :integer
    add_column :wash_sale_courses, :prepaid_sales_amount, :integer
  end
end
