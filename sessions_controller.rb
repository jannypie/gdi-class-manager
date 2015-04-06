class SessionsController < ApplicationController  
  skip_before_action :require_login, only: [:new, :create]

  def create
    if user = User.authenticate(params[:session])
      session[:current_user_id] = user.id
      redirect_to user_path
    else
      @error = "sername or password invalid"
      render 'sessions/new'
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end
end
