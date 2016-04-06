class Comment < ActiveRecord::Base
  belongs_to :bulb
  belongs_to :user
end
