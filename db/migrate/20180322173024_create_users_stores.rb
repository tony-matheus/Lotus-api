class CreateUsersStores < ActiveRecord::Migration[5.1]
  def change
    create_table :users_stores do |t|
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
