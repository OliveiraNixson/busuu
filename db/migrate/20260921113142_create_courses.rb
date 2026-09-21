class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :language, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
