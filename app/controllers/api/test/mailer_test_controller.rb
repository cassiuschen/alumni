class Api::Test::MailerTestController < Api::Test::BaseController
  def success
    @user = User.where(_id: params[:id].to_i).first || User.all.first
    AuthMailer.success(@user).deliver_now
    render json: {status: 200}
  end
end