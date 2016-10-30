class DonorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_donor, only: [:show, :edit, :update, :destroy, :update_stage]
  #before_action :set_event, only: [:index, :edit, :show, :update]

  # GET /donors
  # GET /donors.json
  def index
    if params[:search_name].present?
      if params[:search_cat].present?
        # search for name and category
        @donors = Donor.by_event_name_and_stage(@event.id, params[:search_name], params[:search_cat])
      else
        @donors = Donor.by_event_and_name(@event.id, params[:search_name])
      end
    elsif params[:search_cat].present?
      #show all in cat
      @donors = Donor.by_event_and_stage(@event.id, params[:search_cat])
    else
      @donors = Donor.by_event(@event.id).order(sort_column)
    end

    @search_placeholder = params[:search_name] || ""

    respond_to do |format|
      format.html
      format.csv { render text: @donors.to_csv }
    end
  end

  # GET /donors/1
  # GET /donors/1.json
  def show
    @items = @donor.items.where(event_id: @event.id)
    @contacts = @donor.contacts.where(event_id: @event.id)

    #if @items.blank? then @items = []

  end

  # GET /donors/new
  def new
    @donor = Donor.new
  end

  # GET /donors/1/edit
  def edit
  end

  # POST /donors/import
  def import
    Donor.import(params[:file])
    redirect_to root_url, notice: "Donors imported."
  end

  # POST /donors
  # POST /donors.json
  def create
    @donor = Donor.new(donor_params)

    if @donor.save
      redirect_to event_donor_path(@event, @donor), notice: 'Donor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /donors/1
  # PATCH/PUT /donors/1.json
  def update
      if @donor.update(donor_params)
        redirect_to event_donor_path(@event, @donor), notice: 'Donor was successfully updated.'
      else
        render :edit
      end
  end

  def update_stage
    @donor.set_stage(params[:donor][:stage], @event)
    respond_to do |format|
      format.html { redirect_to event_donor_path(@event, @donor) }
      format.js
    end
  end

  # DELETE /donors/1
  # DELETE /donors/1.json
  def destroy
    @donor.destroy
    redirect_to event_donors_url(@event), notice: 'Donor was successfully destroyed.'
  end

 def destroy_all
   Donor.destroy_all
   redirect_to event_donors_path(@event)
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donor
      @donor = Donor.find(params[:id])
    end

    # def set_event
    #   @event_id = params[:event_id]
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donor_params
      params.require(:donor).permit(:company, :first_name, :last_name, :title, :phone, :email, :address1, :address2, :city, :state, :zip, :website, :status, :has_donated, :stage)
    end

    def sort_column
      Donor.column_names.include?(params[:sort]) ? params[:sort] : "company"
    end
end
