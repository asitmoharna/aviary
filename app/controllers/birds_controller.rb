class BirdsController < ApplicationController
  # Get the list of birds IDs as per
  # https://gist.github.com/sebdah/265f4255cb302c80abd4#file-get-birds-response-json 
  def index
    handle_exception do
      bird_ids = Bird.visible.map(&:id).map(&:to_s)
      render json: bird_ids, status: :ok
    end
  end
end
