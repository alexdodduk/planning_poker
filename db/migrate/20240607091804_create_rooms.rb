class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.boolean :revealed, null: false, default: false

      t.timestamps
    end
  end
end
