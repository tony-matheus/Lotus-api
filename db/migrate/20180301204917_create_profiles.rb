class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|

      t.string :profile_type, :limit => 1, :null => false
      t.integer :function
      t.integer :current_store
      t.string :full_name
      t.string :cpf
      t.date :birthday
      t.string :gender
      
      t.timestamps
    end
  end
end
