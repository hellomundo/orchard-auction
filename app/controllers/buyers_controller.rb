class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buyer, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      bid = params[:search].to_i - 100
      @buyer = Buyer.find_by_id(bid)
      if @buyer
        redirect_to @buyer
      else
        redirect_to buyers_path, notice: "Sorry, I couldn't find that buyer."
      end
    else
      @buyers = Buyer.all
    end
  end

  def show
    @win = Win.new
    @total = Win.total_for_buyer(@buyer)
  end

  def new
    @buyer = Buyer.new
  end

  def edit
  end

  def create
    @buyer = Buyer.new(buyer_params)

    if @buyer.save
      redirect_to @buyer, notice: 'Buyer was successfully created.'
    else
      render :new
    end

  end

  def update


    if @buyer.update(buyer_params)
      redirect_to @buyer, notice: 'Buyer was successfully created.'
    else
      render :edit
    end
  end

  def destroy
    @buyer.destroy
    redirect_to buyers_url, notice: 'Buyer was successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_buyer
    @buyer = Buyer.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    # test to make sure :search is needed
  def buyer_params
    params.require(:buyer).permit(:first_name, :last_name, :email, :search)
  end

end
