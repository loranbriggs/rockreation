class SeatsController < ApplicationController
  def show
    @seat = Seat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xrefUR }
    end
  end
  
  def list
    @seats = Seat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @xrefUR }
    end
  end

  def update
    @seat = Seat.find(params[:id])
    if current_user.id == @seat.user_id
      if @seat.update_attributes(:drop => 1 )
        redirect_to seats_path, :notice => "seat drop initiated"
      else
        redirect_to seats_path, :alert => "an error occured during the seat drop proccess"
      end
    else
      if @seat.update_attributes(:user_id => current_user.id, :drop => 0)
        redirect_to seats_path, :notice => "seat taken"
      else
        redirect_to seats_path, :alert => "an error occured during the seat regestration proccess"
      end
    end
  end

  def show
  end

  def destroy
    @seat = Seat.find(params[:id])
    @seat.destroy
    redirect_to seat_path, :alert => "shift deleted"
  end
end
