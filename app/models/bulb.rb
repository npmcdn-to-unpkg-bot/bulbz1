class Bulb < ActiveRecord::Base
  belongs_to :user
  belongs_to :app
  belongs_to :shop
  belongs_to :service
  belongs_to :platform
  has_many :comments
  has_many :keywords

end
