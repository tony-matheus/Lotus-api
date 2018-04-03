class CreateImagesProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :images_products do |t|
      t.references :product, foreign_key: true
      t.attachment :image
      t.timestamps
    end
  end
end
