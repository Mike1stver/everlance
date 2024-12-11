class RegistrationsController < ApplicationController

  def create
    user = User.create!(permitted_params)
    render json: user
  end


  def permitted_params
    params.require(:user).permit(:password, :email, :password_confirmation)
  end
end