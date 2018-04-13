class CreateImagesStores < ActiveRecord::Migration[5.1]
  def change
    create_table :images_stores do |t|
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
