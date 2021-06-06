class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :encrypted_password, null: false, default: ""
      t.timestamps null: false
    end
  end
end
