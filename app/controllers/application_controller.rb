class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def handle_exception
    yield
  rescue Mongoid::Errors::DocumentNotFound => ex0
    render json: { error: ex0.problem, code: 404 }, status: :not_found
  rescue ArgumentError => ex1
    render json: { error: ex1.message, code: 422 }, status: :unprocessable_entity
  rescue StandardError => ex2
    render json: { error: ex2.message, code: 500 }, status: :internal_error
  end
end
