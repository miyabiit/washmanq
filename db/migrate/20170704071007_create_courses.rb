class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :basic_price, default: 0
      t.integer :special_price, default: 0

      t.timestamps
    end
  end
end
