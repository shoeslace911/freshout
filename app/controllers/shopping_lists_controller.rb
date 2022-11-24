class ShoppingListsController < ApplicationController
  def show
    @shopping_list = ShoppingList.find(params[:id])
    @items = Item.all
    @house_food = HouseFood.new
    authorize @shopping_list
  end
end
