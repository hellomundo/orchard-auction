class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  #layout "events", except: [:show]
  #layout "application", only: [:show]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    total_donors = Donor.count
    # how many donors have donated
    @committed_donors = Status.joins(:donor).where(stage: 4, event_id: @event.id).count
    # how many donors have been followed up with
    @uncommitted_donors = total_donors - @committed_donors
    # how may items have been donated
    @items_donated = Item.where(event_id: @event.id).count
    # what is the overall value of donations
    @total_value = Item.where(event_id: @event.id).sum("fmv")

    @total_won = Win.where(event_id: @event.id).sum(:price)
    @total_pledged = Pledge.where(event_id: @event.id).sum(:amount)
    @total_payments = Payment.where(event_id: @event.id).sum(:amount)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        ender :new
      end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
      edirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event]
      params.require(:event).permit(:date, :theme)

    end
end
