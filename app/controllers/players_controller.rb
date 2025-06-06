class PlayersController < ApplicationController
  before_action :set_player, only: %i[update destroy]

  # POST /players or /players.json
  def create
    @player = Player.new(new_player_params)

    respond_to do |format|
      if @player.save
        room = @player.room
        session["player_id"] = @player.id

        format.html { redirect_to room_url(room), notice: "Welcome #{@player.name}!" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to room_url(@player.room), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            @player, # the things that gets replace, in this case it looks for the `<li id="123">...</li>` DOM node
            partial: "players/list_item_player", # what you want to replace the DOM node with
            locals: { player: @player }) # what you pass to the partial view to populate it
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @player.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Thanks for playing!" }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:id])
  end

  def new_player_params
    params.require(:player).permit(:room_id, :name)
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:room_id, :score, :name, :abstain)
  end
end
