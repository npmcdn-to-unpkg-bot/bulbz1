class BulbMailer < ApplicationMailer
default from: "BULBZ - A Home for your Ideas"

  def new_comment_on_bulb(comment)
    @comment = comment
    @bulb = Bulb.find_by(:id => comment.bulb_id)
    @comment_creator = User.find_by(:id => comment.user_id)
    mail to: @bulb.user.email, :subject => "New comment on one of your bulbz"
  end


end
