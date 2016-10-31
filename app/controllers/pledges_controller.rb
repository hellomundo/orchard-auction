class PledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pledge, only: [:show, :edit, :update, :destroy]

  def index
    @pledges = set_pledges(@event)
  end

  def show
  end

  def new
    @pledge = Pledge.new
    @pledges = set_pledges(@event)
  end

  def edit
    @pledges = set_pledges(@event)
  end

  def create
    @pledges = set_pledges(@event)
    @pledge = Pledge.new(pledge_params)
    @pledge.event_id = @event.id

    if @pledge.save
      respond_to do |format|
        format.html { redirect_to @pledge, notice: 'Okay, I recorded that pledge.'}
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
    @pledges = set_pledges(@event)
    if @pledge.update(pledge_params)
      respond_to do |format|
        format.html { redirect_to @pledge, notice: 'Pledge was successfully updated.'}
        format.js
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @pledges = set_pledges(@event)
    @pledge.destroy
    respond_to do |format|
      format.html { redirect_to pledges_url, notice: 'Okay, I deleted that pledge.' }
      format.js
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_pledge
    @pledge = Pledge.find(params[:id])
  end

  def set_pledges(event)
    @pledges = Pledge.by_event(event)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def pledge_params
    params.require(:pledge).permit(:buyer_id, :amount, :pledge_type)
  end

end
