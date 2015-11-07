class ContactsController < ApplicationController
  def create
    @donor = Donor.find(params[:donor_id])
    @contact = @donor.contacts.new(contact_params)
    @contact.user = current_user
    #if statement around this to check for success?
    @contact.save
    redirect_to donor_path(@donor)
  end

  private
    def contact_params
      params.require(:contact).permit(:contacted_on, :channel, :note)
  end
end
