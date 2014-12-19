class Gallery < ActiveRecord::Base
  belongs_to :user, foreign_key: "creator_id"

  has_many :projects
end
