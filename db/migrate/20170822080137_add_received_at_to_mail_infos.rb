class AddReceivedAtToMailInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :mail_infos, :received_at, :datetime
  end
end
