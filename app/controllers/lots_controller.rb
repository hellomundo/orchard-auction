class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lot, only: [:show, :edit, :update, :destroy]

  # GET /lots
  # GET /lots.json
  def index
    #@lots = Lot.where(event_id: @event.id).order(:id)
    @lots = Lot.joins("JOIN items on lots.id = items.lot_id")
               .select("lots.*, sum(items.fmv) as total_fmv")
               .where(event_id: @event.id)
               .group('lots.id')
               .order('lots.id')
    respond_to do |format|
      format.html
      format.csv { render text: @lots.to_csv }
      format.pdf do
        pdf = BidBooklet.new(view_context)
        pdf.build_document(@lots)
        send_data pdf.render, filename: "bid_sheets.pdf", type: "application/pdf"
      end
    end
  end

  # GET /lots/1
  # GET /lots/1.json
  def show
    @available_items = Item.where("event_id = ? AND is_available = ? AND lot_id IS NULL", @event.id, true)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = BidSheet.new(view_context)
        pdf.build_sheet(@lot)
        send_data pdf.render, filename: "bid_sheet_#{@lot.lot_number}.pdf", type: "application/pdf"
      end
    end
  end

  # GET /lots/new
  def new
    @lot = Lot.new
    # remove this later
    @items = Item.where("event_id = ? AND lot_id IS NULL", @event.id)
  end

  # GET /lots/1/edit
  def edit
    #remove this later
    @items = Item.where("event_id = ? AND lot_id IS NULL", @event.id)
  end

  # to add/remove items from the lot
  def toggle
    @msg = ""
    @added = false;
    @lot = Lot.find(params[:id])
    @item = Item.find(params[:item_id])
    @available_items = Item.where("event_id = ? AND lot_id IS NULL", @event.id)

    if(@lot.items.exists?(@item.id))
      # add the association
      @msg = "I found the record, deleting it"
      @lot.items.delete(@item)
      @lot.save
    else
      # delete the association
      @added = true;
      @msg = "Didn't find it, need to add it"
      @lot.items << @item
      @lot.save
    end

    respond_to do |format|
      format.js {}
    end
  end

  def generate
    # find every item that isn't in a lot
    @available_items = Item.where("event_id = ? AND is_available = ? AND lot_id IS NULL", @event.id, true)
    # create a new lot for each item
    for item in @available_items
      lot = Lot.new()
      lot.items << item
      lot.event_id = item.event_id
      lot.save
    end

    redirect_to event_lots_path(@event)
  end

  def destroy_all
    Lot.destroy_all
    redirect_to lots_path
  end
  # POST /lots
  # POST /lots.json
  def create
    @lot = Lot.new(lot_params)
    @lot.event_id = @event.id
    # a lot must have at least one item
    # if(params[:item_ids].blank?)
    #   redirect_to @lot, notice: 'You must add at least one item to the lot.'
    #   return
    # end

    if @lot.save
      #update the items with this lot id
      Item.where(id: params[:item_ids]).update_all(lot_id: @lot.id)
      redirect_to event_lot_path(@event, @lot), notice: 'Lot was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /lots/1
  # PATCH/PUT /lots/1.json
  def update
      if @lot.update(lot_params)
        redirect_to event_lot_path(@event, @lot), notice: 'Lot was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /lots/1
  # DELETE /lots/1.json
  def destroy
    @lot.destroy
    redirect_to event_lots_path(@event), notice: 'Lot was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lot
      @lot = Lot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lot_params
      params.require(:lot).permit(:name, :description, :opening_price, :bid_increment, :buy_now_price, :quantity_available, :table_number )
    end
end
