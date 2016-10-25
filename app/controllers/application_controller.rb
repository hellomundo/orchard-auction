class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_event

  private

  def set_event
    event_id = params[:event_id];

    if event_id
      @event = Event.find(event_id)
    else
      @event = Event.last
    end
  end

end
