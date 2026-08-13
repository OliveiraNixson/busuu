class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :type
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
