class EventsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :new, :show]
  before_filter :choosed_destination?, only: [:create, :new, :show]
  before_filter :signed_in_admin, only: [:destroy]
  before_filter :within_week, only: [:update]
  before_filter :right_user, only: [:edit, :update]
  #before_filter :set_validate_date, only: [:create]

  def calendar_parties
    @events = Event.find_by_sql("select * from Events where event_type = 'Party'")
    @events_by_date = @events.group_by { |e| e.date.strftime('%Y-%m-%d') }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def list_parties
    @events= Event.find_by_sql("select * from Events where event_type = 'Party'")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def calendar_events
    @events = Event.find_by_sql("select * from Events where event_type != 'Party'")
    @events_by_date = @events.group_by { |e| e.date.strftime('%Y-%m-%d') }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def list_events
    @events= Event.find_by_sql("select * from Events where event_type != 'Party'")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def show
    @event = Event.find(params[:id])
    @shifts = Shift.where(:event_id => params[:id])
    @seats = Seat.where(:event_id => params[:id])

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
    @event.user_id = current_user.id
    if current_user.role == 'client'
      @event.validate_date = true
    else
      @event.validate_date = false
    end
    if @event.save
      UserMailer.alert_new_event(@event).deliver
      if @event.event_type == "Party"
        numShifts = @event.participants / 5
        numShifts.times do
          @shift  = Shift.create(:event_id => @event.id, :user_id => nil, :drop => 0)
        end
        redirect_to parties_path, :notice => "Party created"
      else
        numSeats = @event.participants
        numSeats.times do
          @seat  = Seat.create(:event_id => @event.id, :user_id => nil, :drop => 0)
        end
        redirect_to events_path, :notice => "Event created"
      end
    else
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to session.delete(:return_to), :notice => 'Event was successfully updated'
    else
      render :action => :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    @shifts = Shift.destroy_all(:event_id => params[:id])
    @seats  = Seat.destroy_all(:event_id => params[:id])
    redirect_to :back, :alert => "Event deleted"
  end

  def within_week
    @event = Event.find(params[:id])
    if current_user.role == 'client'
      if @event.date <= (Date.today + 7.days)
        redirect_to :back, :alert => 'Cannot edit event within a week of the event,
        call 310-207-7199 or email our special event manager Colin at 
        colin@rockreation.com to arrange otherwise.'
      end
    end
  end
  
  def right_user
    @event = Event.find(params[:id])
    if current_user.role == 'client'
      if @event.user.id != current_user.id
        redirect_to :back, :alert => 'Not your event to edit'
      end
    end
  end
end
