class PagesController < ApplicationController
  def home
    @foods = current_user.house.house_foods.where("expiry_date <= ?", Date.today + 2)
    @items = current_user.house.items.where.not(user: current_user).where.not(seen: true)
    @items.update_all(seen: true)
  end
end
