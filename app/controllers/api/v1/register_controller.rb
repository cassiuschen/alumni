class Api::V1::RegisterController < Api::V1::BaseController
  def create
    @user = User.create_from_angular_params params
    if @user
      render json: {
        status: 200,
        data: {
          name: @user.name,
          BdfzerId: @user.BdfzerId,
          email: @user.email,
          region: @user.zone,
          department: @user.unit,
          graduateAt: @user.graduate_at.to_i
        }
      }
    else
      render json: {
        status: 501
      }
    end
  end

  def get_list
    @list = []
    User.all.each do |u|
      @list << {
        name: u.name,
        graduateAt: u.graduate_at,
        zone: u.zone,
        unit: u.unit
      }
    end
    render json: {
      size: User.all.size,
      data: @list
    }
  end
end
