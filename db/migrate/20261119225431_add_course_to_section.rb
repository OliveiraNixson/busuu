class AddCourseToSection < ActiveRecord::Migration[8.1]
  def change
    add_reference :sections, :course, null: true, foreign_key: true
  end
end
