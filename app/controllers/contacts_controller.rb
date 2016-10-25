class ContactsController < ApplicationController
  before_action :authenticate_user!

  def create
    # fix - what if you can't find this donor?
    @donor = Donor.find(params[:donor_id])
    @contact = @donor.contacts.new(contact_params)
    @contact.user = current_user
    #if statement around this to check for success?
    @contact.save
    redirect_to event_donor_path(@event, @donor)
  end

  private
    def contact_params
      params.require(:contact).permit(:contacted_on, :channel, :note)
  end
end
