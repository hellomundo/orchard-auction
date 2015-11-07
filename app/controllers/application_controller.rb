class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # authenticate
  before_action :authenticate_user!

  def index
    total_donors = Donor.count
    # how many donors have donated
    @committed_donors = Donor.where(status: 4).count
    # how many donors have been followed up with
    @uncommitted_donors = total_donors - @committed_donors
    # how may items have been donated
    @items_donated = Item.count
    # what is the overall value of donations
    @total_value = Item.sum("fmv")

  end

end
