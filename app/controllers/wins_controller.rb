class WinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_win, only: [:show, :edit, :update, :destroy]

  def index
    @wins = Win.all
  end

  def show
  end

  def new
    @win = Win.new
    @wins = Win.all
  end

  def edit
  end

  def create
    @wins = Win.all
    @win = Win.new(win_params)

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
    @wins = Win.all
    @win.destroy
    respond_to do |format|
      format.html { redirect_to wins_url, notice: 'Okay, I deleted that win.' }
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
