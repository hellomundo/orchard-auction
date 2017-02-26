class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buyer, only: [:show, :edit, :update, :destroy, :toggle_paid]

  def index
    if params[:search]
      # fix - put all this in the model
      # check if it is a string or a number
      query = params[:search]
      # is it a number?
      if query.to_i.to_s == query
        bid = query.to_i - 100
        @buyers = Buyer.where(id: bid, event_id: @event.id)
      else
        #@buyers = Buyer.where('event_id = :eid AND (lower(last_name) LIKE :search OR lower(first_name) LIKE :search)', search: "%#{query.downcase}%", eid: @event.id)
        @buyers = Buyer.joins("LEFT OUTER JOIN wins on buyers.id = wins.buyer_id")
                       .joins("LEFT OUTER JOIN pledges on buyers.id = pledges.buyer_id")
                       .joins("LEFT OUTER JOIN payments on buyers.id = payments.buyer_id")
                       .where('buyers.event_id = :eid AND (lower(buyers.last_name) LIKE :search OR lower(buyers.first_name) LIKE :search)', search: "%#{query.downcase}%", eid: @event.id)
                       .select("buyers.*, sum(wins.price + pledges.amount - payments.amount) as balance")
                       .group('buyers.id')
                       .order('buyers.last_name')
      end

      if @buyers.blank?
        redirect_to event_buyers_path(@event), notice: "Sorry, I couldn't find that buyer."
      elsif @buyers.length == 1
        redirect_to event_buyer_path(@event, @buyers.first)
      end
    else
      @buyers = Buyer.joins("LEFT OUTER JOIN wins on buyers.id = wins.buyer_id")
                     .joins("LEFT OUTER JOIN pledges on buyers.id = pledges.buyer_id")
                     .joins("LEFT OUTER JOIN payments on buyers.id = payments.buyer_id")
                     .where(event_id: @event.id)
                     .select("buyers.*, sum(wins.price + pledges.amount - payments.amount) as balance")
                     .group('buyers.id')
                     .order('buyers.last_name')
    end
  end

  def show
    @win = Win.new
    @win_total = Win.event_total_for_buyer(@event, @buyer)
    @pledge_total = Pledge.event_total_for_buyer(@event, @buyer)
    @payment_total = Payment.event_total_for_buyer(@event, @buyer)
    @balance = @win_total + @pledge_total - @payment_total
  end

  def new
    @buyer = Buyer.new
  end

  def edit
  end

  def create
    @buyer = Buyer.new(buyer_params)
    @buyer.event_id = @event.id

    if @buyer.save
      redirect_to event_buyer_path(@event, @buyer), notice: 'Buyer was successfully created.'
    else
      render :new
    end

  end

  def update
    if @buyer.update(buyer_params)
      redirect_to event_buyer_path(@event, @buyer), notice: 'Buyer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @buyer.destroy
    redirect_to event_buyers_path(@event), notice: 'Buyer was successfully destroyed.'
  end

  def toggle_paid
    @buyer.toggle_paid
  end

  # def destroy_all
  #   Buyer.destroy_all
  #   redirect_to buyers_path
  # end

  # POST /buyers/import
  def import
    Buyer.import(params[:file], @event.id)
    redirect_to event_buyers_path(@event), notice: "Buyers imported."
  end


  private
  def buyer_list
  end
    # Use callbacks to share common setup or constraints between actions.
  def set_buyer
    @buyer = Buyer.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    # test to make sure :search is needed
  def buyer_params
    params.require(:buyer).permit(:first_name, :last_name, :email, :telephone, :guests, :search)
  end

end
