class CreateServicesProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :services_products do |t|
      t.references :services, foreign_key: true
      t.references :products, foreign_key: true

      t.timestamps
    end
  end
end
