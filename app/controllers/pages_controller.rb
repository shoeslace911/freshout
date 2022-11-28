class PagesController < ApplicationController
  def home
    @foods = current_user.house.house_foods.where("expiry_date <= ?", Date.today + 2)
  end
end
