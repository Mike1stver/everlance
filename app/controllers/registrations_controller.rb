class RegistrationsController < ApplicationController

  def create
    user = User.create!(permitted_params)

    if user
      render json: user
    else
      render json: {error: "Error"}, status: :internal_server_error
    end
  end


  def permitted_params
    params.require(:user).permit(:password, :email, :password_confirmation)
  end
end