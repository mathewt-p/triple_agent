class SessionsController < ApplicationController

  def create
    # user = User.find_or_create_by(ip_address: request.ip)
    # if user.update(username: params[:session][:username])
    return redirect_to root_path if current_user
    user = User.find_or_create_by(username: params[:session][:username], ip_address: "asdasd")
    if user
      log_in(user)
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end