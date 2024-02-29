class AddStatusToConversations < ActiveRecord::Migration[7.1]
  def change
    add_column :conversations, :status, :string, default: "waiting", null: false
  end
end
