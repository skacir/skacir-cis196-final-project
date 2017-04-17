class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully logged in.'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to '/', notice: 'User was successfully logged out.'
  end
end
