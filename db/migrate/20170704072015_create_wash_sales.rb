class CreateWashSales < ActiveRecord::Migration[5.1]
  def change
    create_table :wash_sales do |t|
      t.references :place, null: false, index: true, foreign_key: true
      t.date :target_date, null: false
      t.integer :equipment_num, null: false
      t.references :cource, null: false, index: true, foreign_key: true
      t.integer :sales_count, default: 0
      t.integer :cash_sales_amount, default:  0
      t.integer :prepaid_sales_amount, default: 0

      t.timestamps
    end
  end
end
