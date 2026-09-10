class RenameColumnNomeToNameOfUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, "nome","name"
  end
end
