class MakeCurrentLanguageNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :current_language_id, true
  end
end
