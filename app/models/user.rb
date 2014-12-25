class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  field :mobile,             type: String

  # Main Data
  # BDFZerID格式： "201400100001", 毕业年份 2014， 所在地 北京（001）， 序号 001
  field :BdfzerId,             type: String, default: -> {
    guaduate_at + region.to_s.rjust(3, '0') + _id.to_s.rjust(5, '0')
  }
  validates :BdfzerId,         presence: true, uniqueness: true

  field :region,               type: Integer, default: 84

  field :sexual,               type: String, default: 'Unknown'

  field :guaduate_at,          type: String, default: -> { Time.now.year.to_s }

  field :department,           type: Integer, default: 0
  field :department_member,    type: Boolean, default: false

  field :name,                 type: String

  field :power,                type: Integer, default: 0

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  REGIONS = {
    84  => 'Unknown',
    1   => '北京总部',
    10  => '江浙沪地区分部',
    20  => '东北地区分部',   #包括辽宁、吉林、黑龙江
    30  => '华东南地区分部', #包括山东、安徽、福建、广东、广西、海南
    40  => '华北地区分部',   #包括天津、河北、山西、内蒙古
    50  => '西部地区分部',   #包括宁夏、新疆、青海、陕西、甘肃、四川、云南、贵州、西藏、重庆
    60  => '华中地区分部',   #包括湖北、湖南、河南、江西
    70  => '台港澳地区分部',
    100 => '北美地区分部',
    200 => '欧洲分部',
    300 => '南半球分部'
  }
 
  def department_member?
    !!(department_member)
  end

  def zone
    User::REGIONS[region]
  end

  def role
    case power
    when 0 then 'alumni'
    when 1 then 'secretary'
    when 2 then 'manager'
    when 3 then 'admin'
    end
  end

  def self.create_from_angular_params(params)
    @user = User.create {
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password],
      mobile: params[:mobile],
      guaduate_at: params[:guaduate_at],
    }

end
