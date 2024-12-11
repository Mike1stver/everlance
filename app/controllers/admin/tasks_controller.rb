class Admin::TasksController < ApplicationController
  before_action :verify_login
  before_action :set_task, only: [:show, :destroy, :update]

  def create
    task = current_user.tasks.create!(permitted_params)
    render json: task,  status: :created
  end

  def update
    @task.update!(permitted_params)
    render json: task,  status: :ok
  end

  def index
    tasks = current_user.tasks
    tasks = tasks.where(parse_query_params) if params[:completed].present?
    render json: tasks, status: :ok
  end

  def destroy
    @task.destroy!
  end

  def show
    render json: @task, status: :ok
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

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def parse_query_params
    {
      completed: params[:completed] == "true"
    }
  end
end