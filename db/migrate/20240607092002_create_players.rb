class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
