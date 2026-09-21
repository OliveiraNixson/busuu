class CreateSections < ActiveRecord::Migration[8.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
