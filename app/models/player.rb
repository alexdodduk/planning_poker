class Player < ApplicationRecord
  belongs_to :room

  before_update :reset_score

  after_create_commit -> { broadcast_append_to "room", target: "players", partial: "players/list_item_player", locals: { player: self } }
  after_create_commit -> { broadcast_remove_to "room", target: "loading" }
  after_update_commit -> { broadcast_replace_to "room", partial: "players/list_item_player", locals: { player: self } }
  after_update_commit -> { broadcast_replace_to "room", target: "player_form_#{id}", partial: "players/form", locals: { player: self } }
  after_destroy_commit -> { broadcast_remove_to "room", target: "player_#{id}" }

  def voted?
    score || abstain?
  end

  private

  def reset_score
    self.score = nil if abstain?
  end
end
