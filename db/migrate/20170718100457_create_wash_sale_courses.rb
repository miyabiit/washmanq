class CreateWashSaleCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :wash_sale_courses do |t|
      t.references :wash_sale, index: true, null: false, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :sales_count
    end
  end
end
