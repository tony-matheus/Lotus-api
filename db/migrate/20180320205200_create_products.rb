class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :store, foreign_key: true

      t.string :name
      t.integer :amount
      t.decimal :price

      t.timestamps
    end
  end
end
