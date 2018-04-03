class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true

      t.string :street
      t.string :neighborhood
      t.string :public_place
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :country
      t.string :complement
      t.string :cep

      t.timestamps
    end
  end
end
