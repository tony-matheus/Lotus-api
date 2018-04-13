class CreateServicesTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :services_types do |t|
      t.references :services, foreign_key: true
      t.attachment :image
      t.timestamps
    end
  end
end
