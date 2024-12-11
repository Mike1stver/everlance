class SessionsController < ApplicationController

  def create
    user = User.find_by(email: permitted_params[:email]).try(:authenticate, permitted_params[:password])

    if user
      session[:user_id] = user.id
      render json: user
    else
      render json: {error: "Error"} status: :not_found
    end
  end


  def permitted_params
    params.require(:user).permit(:password, :email)
  end
end