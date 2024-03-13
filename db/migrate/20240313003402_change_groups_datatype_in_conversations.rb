class ChangeGroupsDatatypeInConversations < ActiveRecord::Migration[7.1]
  def change
    change_column :conversations, :groups, :string
  end
end
