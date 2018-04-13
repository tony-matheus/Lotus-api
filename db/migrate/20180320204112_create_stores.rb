class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :CNPJ
      t.string :category
      t.string :longitude
      t.string :latitude
      
      t.timestamps
    end
  end
end
