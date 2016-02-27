class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

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
    @item = Donor.new
  end

  # GET /donor/1/items/1/edit
  def edit
    @donor = Donor.find(params[:donor_id])
    @item = @donor.items.find(params[:id])
  end

  # POST /donor/1/items/1
  def create
    @donor = Donor.find(params[:donor_id])
    @item = @donor.items.create(item_params)
    respond_to do |format|
      format.html { redirect_to donor_path(@donor) }
      format.js
    end
  end

  # PATCH/PUT /donor/1/items/1
  # PATCH/PUT /items/1.json
  def update
    @donor = Donor.find(params[:donor_id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to donor_item_path(@donor, @item), notice: 'Item was successfully updated.' }
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
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /donors/import
  def import
    Item.import(params[:file])
    redirect_to items_path, notice: "Items imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :fmv, :restrictions, :category, :format, :opening_price)
    end
end
