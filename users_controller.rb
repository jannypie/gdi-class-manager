class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path
    else
      render "/users/show"
    end
  end

  def show
    if authorized_access?(params[:id])
      @user = User.find_by_id(params[:id]) 
      @posts = @user.posts.order(created_at: :desc)
    end
  end

  def edit
    @user = User.find_by_id(params[:id]) if authorized_access?(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update(user_params)
      redirect_to user_path
    else
      render edit_user_path
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    if authorized_access?(user.id)
      user.destroy
      session[:current_user_id] = nil
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
