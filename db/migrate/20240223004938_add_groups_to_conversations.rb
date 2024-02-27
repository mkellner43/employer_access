class AddGroupsToConversations < ActiveRecord::Migration[7.1]
  def change
    add_column :conversations, :groups, :integer
  end
end
