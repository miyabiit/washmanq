class CreateMonthlySales < ActiveRecord::Migration[5.1]
  def change
    create_table :monthly_sales do |t|
      t.references :place, null: false, index: true, foreign_key: true
      t.string :type, null: false
      t.string :target_month, null: false
      t.integer :equipment_num, null: false
      t.integer :cash_sales_amount, default: 0
      t.integer :prepaid_sales_amount, default: 0
      t.integer :sales_count, default: 0
      t.string :operated_by, default: 'system'

      t.timestamps null: false
    end
  end
end
