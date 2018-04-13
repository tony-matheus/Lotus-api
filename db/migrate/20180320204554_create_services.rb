class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.references :store, foreign_key: true

      t.string :title
      t.string :name
      t.string :description
      t.string :price
      t.string :time
      t.integer :type
      
      t.timestamps
    end
  end
end
