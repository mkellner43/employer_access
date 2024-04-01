class ChangeDefaultStatusForConversations < ActiveRecord::Migration[7.1]
  def change
    change_column_default :conversations, :status, 'completed'
  end
end
