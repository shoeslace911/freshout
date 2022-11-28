# To deliver this notification:
#
notif = FoodNotification.with(amount: ).deliver(current_user)
notif.FoodNotification.deliver_later(User.all)

class FoodNotification < Noticed::Base
  # Add your delivery methods

  deliver_by :database, format: :to_database
  deliver_by :slack, debug: true
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params


  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
