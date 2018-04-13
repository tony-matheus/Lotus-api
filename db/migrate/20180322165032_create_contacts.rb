class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true, null: nil
      t.references :store, foreign_key: true, null: nil

      t.string :phone
      t.string :cellphone
      t.string :email
      t.timestamps
    end
  end
end
