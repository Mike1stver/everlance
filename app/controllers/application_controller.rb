class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private
  
  def record_not_found(e)
    render json: { error: "#{e.model} not found" }, status: :not_found
  end

  def record_invalid(e)
    render json: { error: e.message }, status: :bad_request
  end
end
