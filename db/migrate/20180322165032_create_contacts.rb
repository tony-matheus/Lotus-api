class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :profile, foreign_key: true, null: nil
      t.references :store, foreign_key: true, null: nil

      t.string :phone
      t.string :type_phone
      t.string :email
      t.timestamps
    end
  end
end
