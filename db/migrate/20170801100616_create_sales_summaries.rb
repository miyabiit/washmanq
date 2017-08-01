class CreateSalesSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :sales_summaries do |t|
      t.references :place, index: true, null: false, foreign_key: true
      t.string :target_month, null: false
      t.integer :sales_count, default: 0
      t.integer :sales_amount, default: 0

      t.timestamps
    end
  end
end
