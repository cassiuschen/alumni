class Api::V1::RegisterController < Api::V1::BaseController
  def create
    if User.create_from_api_params params
      render json: {status: 200}
    end
  end
end
