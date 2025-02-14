class Room < ApplicationRecord
  after_update_commit -> { broadcast_replace_to "room" }
  # after_update_commit -> do
  #   players.each do |player|
  #     broadcast_replace_to "room", target: "player_form", partial: "players/form", locals: { player: }
  #   end
  # end

  has_many :players, dependent: :destroy
end
