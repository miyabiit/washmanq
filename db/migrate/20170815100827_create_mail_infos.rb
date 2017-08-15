class CreateMailInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_infos do |t|
      t.string :title
      t.string :from
      t.text :content
      t.timestamps
    end
  end
end
