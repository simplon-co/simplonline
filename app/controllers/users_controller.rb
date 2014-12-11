class UsersController < ApplicationController
  skip_filter :remote_cant_access

  #j'ai rajouté ça
  def forem_user
    forem_user = current_user
  end

  def index
    @users = User.all
  end


  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update user_params
      redirect_to root_url
    else
      render 'edit', notice: "#{user_params} n'est pas disponible"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
