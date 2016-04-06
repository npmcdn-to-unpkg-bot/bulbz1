class User < ActiveRecord::Base

    has_many :bulbs
    has_many :comments

    def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.profile_picture = auth["info"]["image"] + "?width=600"
    end
  end
end
