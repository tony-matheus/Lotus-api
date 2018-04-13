class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true

      t.string :profile_type, :limit => 1, :null => false
      t.integer :function
      t.integer :current_store
      t.timestamps
    end
  end
end
