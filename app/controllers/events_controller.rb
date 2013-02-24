class EventsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :new, :show]
  before_filter :choosed_destination?, only: [:create, :new, :show]
  before_filter :signed_in_admin, only: [:destroy]
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
      redirect_to events_path, :notice => "Event created"
      if @event.event_type == "Party"
        numShifts = @event.participants / 5
        numShifts.times do
          @shift  = Shift.create(:event_id => @event.id, :user_id => nil, :drop => 0)
        end
      else
        numSeats = @event.participants
        numSeats.times do
          @seat  = Seat.create(:event_id => @event.id, :user_id => nil, :drop => 0)
        end
      end
    else
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      if current_user.role != 'admin'
        redirect_to events_path, :notice => 'Event was successfully updated'
      else
        redirect_to events_path, :notice => 'Event was successfully updated'
      end
    else
      render :action => :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    @shifts = Shift.destroy_all(:event_id => params[:id])
    @seats  = Seat.destroy_all(:event_id => params[:id])
    redirect_to events_list_path, :alert => "Event deleted"
  end

  #def set_validate_date
  #end
end
