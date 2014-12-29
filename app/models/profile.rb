class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :study_at,	type: String

  field :avatar,	type: String

  field :major,		type: String

  field :des,		type: String

  belongs_to :user, class_name: "User", inverse_of: :profile

end
