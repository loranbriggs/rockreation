class UsersController < ApplicationController

  before_filter :signed_in_admin, only: [:index, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      if current_user.role != 'admin'
        redirect_to root_url, :notice => 'User was successfully updated'
      else
        redirect_to users_path, :notice => 'User was successfully updated'
      end
    else
      render :action => :edit
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user   = User.find(params[:id])
    @shifts = Shift.where(:user_id => params[:id])
    @seats  = Seat.where(:user_id => params[:id])
    @events = Event.where(:user_id => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :alert => "user deleted"
  end

end
