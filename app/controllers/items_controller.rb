class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :toggle_availability, :destroy]
  # GET /items
  # GET /items.json
  def index
    #@items = Item.all
    event_id = params[:event_id] || Event.last.id;
    @items = Item.includes(:donor).includes(:lot).where(event_id: params[:event_id]).order("#{sort_column} #{sort_direction}")

    respond_to do |format|
      format.html
      format.csv { render text: @items.to_csv }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /donor/1/items/1/edit
  def edit
    @donor = @item.donor
  end

  # POST /donor/1/items/1
  def create
    @donor = Donor.find(item_params[:donor_id])
    # CHANGE
    # update donor status to "donated"
    # or somehow refactor this into the donor model
    @item = @event.items.create(item_params)
    @items = @event.items.where(donor_id: @donor.id)
    respond_to do |format|
      format.html { redirect_to event_donor_path(@event, @donor) }
      format.js
    end
  end

  # PATCH/PUT /donor/1/items/1
  # PATCH/PUT /items/1.json
  def update
    @donor = Donor.find(item_params[:donor_id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to event_item_path(@item.event, @item), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    donor = @item.donor
    @item.destroy

    # CHANGE
    # if this is the last time, change the status away from "donated"

    @items = donor.items.where(event_id: params[:event_id])
    #@items = donor.items
    respond_to do |format|
      format.html { redirect_to event_items_url(@event), notice: 'Item was successfully destroyed.' }
      format.js
    end
  end

  # POST /donors/import
  def import
    Item.import(params[:file])
    redirect_to items_path, notice: "Items imported."
  end

  def toggle_availability
    @item.is_available = !@item.is_available
    #should try to catch error here
    @item.save

    respond_to do |format|
      format.js
    end
  end

  private
    def sortable_columns
      ["name", "category", "format", "donors.company", "fmv"]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:donor_id, :name, :description, :fmv, :restrictions, :category, :format, :notes, :opening_price)
    end
end
