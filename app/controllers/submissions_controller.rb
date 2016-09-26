class SubmissionsController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, except: [:index, :new, :create]

  def index
  end

  # GET /items/new
  def new
    @submission = Submission.new
  end


  # POST /donor/1/items/1
  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      respond_to do |format|
        format.html { redirect_to submissions_path, notice: 'Okay, I recorded that item. Thanks!'}
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  def submission_params
    params.require(:submission).permit(:business, :contact, :telephone, :email, :item, :category, :format, :fmv, :description, :restrictions)
  end


end
