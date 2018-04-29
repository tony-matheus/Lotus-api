class FkToBeNull < ActiveRecord::Migration[5.1]
  def change
      change_column_default(:addresses, :store_id, nil)
      change_column_default(:addresses, :user_id, nil)
      change_column_default(:contacts, :store_id, nil)
      change_column_default(:contacts, :user_id, nil)
      #change this after
      change_column_default(:images_stores, :store_id, nil)

  end
end
