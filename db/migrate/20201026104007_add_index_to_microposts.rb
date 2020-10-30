class AddIndexToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_index :microposts, %i[user_id created_at]
  end
end
