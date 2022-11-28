class PagesController < ApplicationController

  def home
    @items = current_user.house.items.where.not(user: current_user).where.not(seen: true)
    @items.update_all(seen: true)
  end
end
