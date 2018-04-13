class CreateImagesServices < ActiveRecord::Migration[5.1]
  def change
    create_table :images_services do |t|
      t.references :service, foreign_key: true
      t.attachment :image
      t.timestamps
    end
  end
end
