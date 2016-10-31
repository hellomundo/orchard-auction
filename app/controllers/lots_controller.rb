class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lot, only: [:show, :edit, :update, :destroy]

  # GET /lots
  # GET /lots.json
  def index
    @lots = Lot.where(event_id: @event.id)
    respond_to do |format|
      format.html
      format.csv { render text: @lots.to_csv }
    end
  end

  # GET /lots/1
  # GET /lots/1.json
  def show
    @available_items = Item.where("lot_id IS NULL")
  end

  # GET /lots/new
  def new
    @lot = Lot.new
    # remove this later
    @items = Item.where("lot_id IS NULL")
  end

  # GET /lots/1/edit
  def edit
    #remove this later
    @items = Item.where("lot_id IS NULL")
  end

  # to add/remove items from the lot
  def toggle
    @msg = ""
    @added = false;
    @lot = Lot.find(params[:id])
    @item = Item.find(params[:item_id])
    @available_items = Item.where("lot_id IS NULL")

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
    @available_items = Item.where("lot_id IS NULL")
    # create a new lot for each item
    for item in @available_items
      lot = Lot.new()
      lot.items << item
      lot.save
    end

    redirect_to lots_path
  end

  def destroy_all
    Lot.destroy_all
    redirect_to lots_path
  end
  # POST /lots
  # POST /lots.json
  def create
    @lot = Lot.new(lot_params)
    # a lot must have at least one item
    # if(params[:item_ids].blank?)
    #   redirect_to @lot, notice: 'You must add at least one item to the lot.'
    #   return
    # end

    respond_to do |format|
      if @lot.save
        #update the items with this lot id
        Item.where(id: params[:item_ids]).update_all(lot_id: @lot.id)
        format.html { redirect_to @lot, notice: 'Lot was successfully created.' }
        format.json { render :show, status: :created, location: @lot }
      else
        format.html { render :new }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lots/1
  # PATCH/PUT /lots/1.json
  def update
    respond_to do |format|
      if @lot.update(lot_params)
        format.html { redirect_to @lot, notice: 'Lot was successfully updated.' }
        format.json { render :show, status: :ok, location: @lot }
      else
        format.html { render :edit }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lots/1
  # DELETE /lots/1.json
  def destroy
    @lot.destroy
    respond_to do |format|
      format.html { redirect_to lots_url, notice: 'Lot was successfully destroyed.' }
      format.json { head :no_content }
    end
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
