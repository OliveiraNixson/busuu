class AddCurrentLevelToCourse < ActiveRecord::Migration[8.1]
  def change
    add_reference :courses, :current_level, foreign_key: { to_table: :levels }, null: true
  end
end
