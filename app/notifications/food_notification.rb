# To deliver this notification:
#
# FoodNotification.with(post: @post).deliver_later(current_user)
notif = FoodNotification.with().deliver(current_user)
notif.FoodNotification.deliver_later(User.all)

class FoodNotification < Noticed::Base
  # Add your delivery methods

  deliver_by :database, format: :to_database
  deliver_by :slack, debug: true
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"
  # Add required params
  param :post

  # Define helper methods to make rendering easier.
  #
  def to_database

  end
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
