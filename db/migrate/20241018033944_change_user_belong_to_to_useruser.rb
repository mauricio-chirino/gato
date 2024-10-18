class ChangeUserBelongToToUseruser < ActiveRecord::Migration[7.2]
  def change
    change_column_null :comments, :user_id, true  # Permitir valores nulos en user_id
  end
end
