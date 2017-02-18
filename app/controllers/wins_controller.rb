class WinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_win, only: [:show, :edit, :update, :destroy]

  def index
    @wins = Win.where(event_id: @event.id)
  end

  def show
  end

  def new
    @win = Win.new
    @wins = Win.where(event_id: @event.id)
  end

  def edit
  end

  def create
    @wins = Win.where(event_id: @event.id)
    @win = Win.new(win_params)
    @win.event_id = @event.id

    if @win.save
      respond_to do |format|
        format.html { redirect_to @win, notice: 'Okay, I recorded that win.'}
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end

  end

  def update
    if @win.update(win_params)
      redirect_to @win, notice: 'Win was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @wins = Win.where(event_id: @event.id)
    @win.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Okay, I deleted that win.' }
      format.js
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_win
    @win = Win.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def win_params
    params.require(:win).permit(:buyer_id, :lot_id, :price)
  end

end
