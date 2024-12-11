class Admin::TasksController < ApplicationController
  before_action :verify_login

  def create
    task = current_user.tasks.create!(permitted_params)
    render json: task,  status: :created
  end

  def update
    task = current_user.tasks.find_by(id: params[:id])
    task.update!(permitted_params)
    render json: task,  status: :ok
  end

  def index
    tasks = current_user.tasks.where(parse_query_params)
    render json: tasks, status: :ok
  end

  def destroy
    task = current_user.tasks.find_by(id: params[:id])
    if task.present?
      task.destroy!
      head :no_content
    else
      render status: :not_found
    end
  end

  def show
    task = current_user.tasks.find_by(id: params[:id])
    render json: task, status: :ok
  end

  private


  def permitted_params
    params.require(:task).permit(:title, :completed, :notes)
  end


  def verify_login
    render status: :unauthorized unless User.find_by(id: session[:user_id])
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def parse_query_params
    {
      completed: params[:completed] == "true"
    }
  end
end