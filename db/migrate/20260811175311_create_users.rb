class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :nome
      t.string :email
      t.string :password
      t.references :current_language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
