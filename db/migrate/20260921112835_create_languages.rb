class CreateLanguages < ActiveRecord::Migration[8.1]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :flag

      t.timestamps
    end
  end
end
