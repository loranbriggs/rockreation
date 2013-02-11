class ShiftsController < ApplicationController
  
  before_filter :signed_in_employee, only: [:take_shift]
  before_filter :signed_in_admin, only: [:destroy]
  
  def show
    @shift = Shift.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xrefUR }
    end
  end

  def list
    @shifts = Shift.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @xrefUR }
    end
  end

  def update
    @shift = Shift.find(params[:id])
    if current_user.id == @shift.user_id
      if @shift.update_attributes(:drop => 1 )
        redirect_to shifts_path, :notice => "shift drop initiated"
      else
        redirect_to shifts_path, :alert => "an error occured during the shift drop proccess"
      end
    else
      if @shift.update_attributes(:user_id => current_user.id, :drop => 0)
        redirect_to shifts_path, :notice => "shift taken"
      else
        redirect_to shifts_path, :alert => "an error occured during the shift regestration proccess"
      end
    end
  end

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
    redirect_to shifts_path, :alert => "shift deleted"
  end
end
