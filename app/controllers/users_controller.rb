class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def show
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'メッセージを更新しました'
    else
      render 'edit'
    end
  end
  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :place, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end