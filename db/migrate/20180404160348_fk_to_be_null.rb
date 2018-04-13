class FkToBeNull < ActiveRecord::Migration[5.1]
  def change
      change_column_default(:addresses, :store_id, nil)
  end
end
