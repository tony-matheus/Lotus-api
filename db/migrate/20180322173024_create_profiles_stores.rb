class CreateUsersStores < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles_stores do |t|
      t.references :profile, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
