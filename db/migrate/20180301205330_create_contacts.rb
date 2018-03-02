class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :profile, foreign_key: true
      t.string :phone
      t.string :cellphone
      t.string :email

      t.timestamps
    end
  end
end
