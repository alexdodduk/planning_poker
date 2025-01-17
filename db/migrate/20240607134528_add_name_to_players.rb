class AddNameToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :name, :text, null: false
  end
end
