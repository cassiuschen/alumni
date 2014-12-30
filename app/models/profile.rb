class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :study_at,	type: String

  field :avatar,	type: String

  field :major,		type: String

  field :des,		type: String

  field :address,	type: String

  field :hasJob,	type: Boolean, default: false

  field :company,	type: String

  field :job,		type: String

  belongs_to :user, class_name: "User", inverse_of: :profile

end
