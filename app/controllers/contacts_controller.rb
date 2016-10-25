class ContactsController < ApplicationController
  before_action :authenticate_user!

  def create
    # fix - what if you can't find this donor?
    @donor = Donor.find(contact_params[:donor_id])
    @contact = @event.contacts.new(contact_params)
    @contact.user = current_user
    #if statement around this to check for success?
    @contact.save
    @contacts = @donor.contacts.where(event_id: @event.id)
    respond_to do |format|
      format.html { redirect_to event_donor_path(@event, @donor) }
      format.js
    end

  end

  private
    def contact_params
      params.require(:contact).permit(:donor_id, :contacted_on, :channel, :note)
  end
end
