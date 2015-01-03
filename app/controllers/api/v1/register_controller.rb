class Api::V1::RegisterController < Api::V1::BaseController
  def create
    if @user = User.create_from_api_params params
      render json: {
        status: 200,
        data: {
          BdfzerId: @user.BdfzerId,
          name: @user.name
        }
      }
    end
  end
end
