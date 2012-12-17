class XrefUserReservationsController < ApplicationController

  before_filter :signed_in_employee, only: [:take_shift]

  def list
    @xrefUR = XrefUserReservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @xrefUR }
    end
  end

  def show
    @xrefUR = XrefUserReservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xrefUR }
    end
  end

  def update
    @xrefUR = XrefUserReservation.find(params[:id])
    if current_user.id == @xrefUR.user_id
      if @xrefUR.update_attributes(:drop_shift => 1 )
        redirect_to reservation_shifts_path, :notice => "shift drop initiated"
      else
        redirect_to reservation_shifts_path, :notice => "an error occured during the shift drop proccess"
      end
    else
      if @xrefUR.update_attributes(:user_id => current_user.id, :drop_shift => 0)
        redirect_to reservation_shifts_path, :notice => "shift taken"
      else
        redirect_to reservation_shifts_path, :notice => "an error occured during the shift regestration proccess"
      end
    end
  end

  def destroy
    @xrefUR = XrefUserReservation.find(params[:id])
    @xrefUR.destroy
    redirect_to reservation_shifts_path, :alert => "shift deleted"
  end

  private

    def signed_in_employee
      redirect_to reservation_shifts_path, alert: "Only an employee can take a shift" unless current_user.role == 'admin' || current_user.role == 'employee'
    end
end
