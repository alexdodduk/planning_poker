class RoomsController < ApplicationController
  before_action :set_room, only: %i[show destroy reveal reset]

  # GET /rooms/1 or /rooms/1.json
  def show
    @host = session[:host] == @room.id
    @player = Player.find_by(id: session[:player_id])
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new

    respond_to do |format|
      if @room.save
        session[:host] = @room.id

        format.html { redirect_to room_url(@room), notice: "Room created. You are the host." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.broadcast_append_to "room", target: "room_#{@room.id}", partial: "rooms/redirect"
    @room.destroy!
  end

  def reveal
    @room.update!(revealed: true)

    respond_to do |format|
      format.html { redirect_to room_url(@room) }
      format.json { head :no_content }
    end
  end

  def reset
    @room.update!(revealed: false)
    @room.players.each { |player| player.update!(score: nil, abstain: false) }

    respond_to do |format|
      format.html { redirect_to room_url(@room) }
      format.json { head :no_content }
    end
  end

  def game_ended
    redirect_to root_path, notice: "Game has ended, thanks for playing!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:revealed)
    end
end
