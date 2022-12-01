class PagesController < ApplicationController
  def home
    @foods = current_user.house.house_foods.where("expiry_date <= ?", Date.today + 2)
    @unseen_items = current_user.house.items.where.not(user: current_user).where.not(seen: true)
    flash.delete(:alert)
    #@items.update_all(seen: true)
  end
end
