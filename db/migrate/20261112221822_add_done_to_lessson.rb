class AddDoneToLessson < ActiveRecord::Migration[8.1]
  def change
    add_column :lessons, :done, :boolean, default: false
  end
end
