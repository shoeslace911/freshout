class ShoppingListsController < ApplicationController
  def show
    @shopping_list = ShoppingList.find(params[:id])
    @items = Item.all
    @house_food = HouseFood.new
    #@items.update_all(seen: true)
    @unseen_items = current_user.house.items.where.not(user: current_user).where.not(seen: true)
    @unseen_items.update_all(seen: true)
    authorize @shopping_list
  end

end
