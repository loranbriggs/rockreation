class ReservationsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :new]
  before_filter :signed_in_admin, only: [:destroy]
  #after_filter :create_xref, only: [:create]

  def calendar
    @reservations= Reservation.all
    @reservations_by_date = @reservations.group_by { |e| e.date.strftime('%Y-%m-%d') }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def list
    @reservations= Reservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    if @reservation.save
      redirect_to reservations_path, :notice => "Reservation Made!"
      @xref  = XrefUserReservation.create(:reservation_id => @reservation.id, :user_id => current_user.id, :host => 1)
      shifts = @reservation.participants / 5
      shifts.times do
        @xref = XrefUserReservation.create(:reservation_id => @reservation.id, :user_id => nil, :host => 0, :drop_shift => 0)
      end
    else
      render "new"
    end
  end

  def update

  end

  def edit

  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    @shifts = XrefUserReservation.destroy_all(:reservation_id => params[:id])
    redirect_to reservations_list_path, :alert => "Reservation deleted"
  end

end
