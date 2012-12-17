class EventsController < ApplicationController

  before_filter :signed_in_user, only: [:create]
  before_filter :signed_in_admin, only: [:destroy]
  #after_filter :create_xref, only: [:create]

  def calendar
    @events = Event.all
    @events_by_date = @events.group_by { |e| e.date.strftime('%Y-%m-%d') }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def list
    @events= Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to reservations_path, :notice => "Event created"
#      @xref  = XrefUserEvent.create(:event_id => @event.id, :user_id => current_user.id, :host => true)
    else
      render "new"
    end
  end

  def update

  end

  def edit

  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, :alert => "Event deleted"
  end

  private

    def signed_in_user
      redirect_to log_in_path, notice: "Please sign in." unless current_user
    end

    def signed_in_admin
      redirect_to reservations_path, notice: "Only an admin can delete a reservation" unless current_user.role == 'admin'
    end

#    def create_xref
#      xref = XrefUserEvent.new
#      xref.user_id = current_user.user_id
#      xref.event_id = this.event_id
#      xref.host = true
#      xref.save
#    end

end
