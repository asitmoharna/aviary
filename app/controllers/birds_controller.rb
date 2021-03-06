class BirdsController < ApplicationController
  # Skip the token as we are not concentrating on authentication
  skip_before_filter  :verify_authenticity_token
  def index
    handle_exception do
      bird_ids = Bird.visible.map(&:id).map(&:to_s)
      render json: bird_ids, status: :ok
    end
  end

  def create
    handle_exception do
      bird = Bird.new(new_bird_params)

      if bird.save
        render json: bird, status: :created
      else
        render json: { error: bird.errors, code: 400 }, status: :bad_request
      end
    end
  end

  def show
    handle_exception do
      bird = Bird.find(params[:id])
      render json: bird, status: :ok
    end
  end

  def destroy
    handle_exception do
      bird = Bird.find(params[:id])
      if bird.destroy
        render nothing: true, status: :ok
      else
        render json: { error: 'Unable to destroy' }, status: :unprocessble_entity
      end
    end
  end

  private

  def new_bird_params
    params.permit(:name, :family, { continents: [] }, :visible, :added)
  end
end
