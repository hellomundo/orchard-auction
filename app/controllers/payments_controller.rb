class PaymentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.all
  end

  def show
  end

  def new
    @payment = Payment.new
    @amount = params[:amount]
    @buyer_id = params[:buyer_id]
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.event_id = @event.id
    @buyer = Buyer.find(params[:payment][:buyer_id])

    if @payment.save
      redirect_to event_buyer_path(@event, @buyer), notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to event_buyer_path(@event, @payment.buyer), notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    buyer = @payment.buyer
    @payment.destroy
    redirect_to event_buyer_path(@event, buyer), notice: 'Payment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    # test to make sure :search is needed
  def payment_params
    params.require(:payment).permit(:form, :amount, :note, :buyer_id)
  end
end
