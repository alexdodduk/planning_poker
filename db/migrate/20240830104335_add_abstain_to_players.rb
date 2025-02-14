class AddAbstainToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :abstain, :boolean, null: false, default: false
  end
end
