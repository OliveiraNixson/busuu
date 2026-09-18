class FixCurrentLanguageForeignKey < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :users, column: :current_language_id
    add_foreign_key :users, :languages, column: :current_language_id
  end
end
