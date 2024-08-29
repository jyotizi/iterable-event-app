class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events
  end

  def create_event
    event = initialize_event
    if event.save
      @response = IterableMockService.new(event, current_user, send_email: params[:send_mail]).track_event
      flash[:notice] = "Event created successfully."
      redirect_to events_path(email: current_user.email)
    else
      flash[:error] = "Can't create Event"
    end
  end

  private

  def initialize_event
    event = current_user.events.new
    event.name = SecureRandom.alphanumeric(10)
    event
  end
end
