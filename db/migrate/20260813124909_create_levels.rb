class CreateLevels < ActiveRecord::Migration[8.1]
  def change
    create_table :levels do |t|
      t.string :code
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
