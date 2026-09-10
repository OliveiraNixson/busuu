class AddSalPasswordToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :password_salt, :string
    rename_column :users, "password", "password_hash" 
  end
end
