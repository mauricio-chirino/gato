class ChangeUserIdNullConstraintInComments2 < ActiveRecord::Migration[7.2]
  def change
    change_column_null :comments, :user_id, false  # Hacer que user_id no permita valores nulos
  end
end
