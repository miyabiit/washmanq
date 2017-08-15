class CreateMailFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_files do |t|
      t.references :mail_info, index: true, null: false, foreign_key: true
      t.attachment :file
      t.timestamps
    end
  end
end
