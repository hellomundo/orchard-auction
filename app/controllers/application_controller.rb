class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :sort_column, :sort_direction
  before_action :set_event


  private

  def set_event
    event_id = params[:event_id];

    if event_id.present?
      @event = Event.find(event_id)
    else
      @event = Event.last
    end
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
