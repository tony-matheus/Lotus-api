class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :profile
      t.integer :function
      t.timestamps
    end
  end
end
