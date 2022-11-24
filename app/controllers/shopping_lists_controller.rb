class ShoppingListsController < ApplicationController
  def show
    @shopping_list = ShoppingList.find(params[:id])
    @items = Item.all
    authorize @shopping_list
  end
end
