class Gallery < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :projects
end
