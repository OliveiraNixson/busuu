class DropUserLanguages < ActiveRecord::Migration[8.1]
  def change
    drop_table :user_languages
  end
end
