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

  def store_all
    @shopping_list = ShoppingList.find(params[:id])
    authorize @shopping_list
    @shopping_list.items.each do |item|
      food = HouseFood.new(
        food: item.food,
        house: current_user.house,
        expiry_date: Date.today + 7,
        bought_date: Date.today,
        amount: item.amount,
        comment: item.comment,
        owned: true
      )
      food.save
      item.destroy
    end
    redirect_to house_foods_path
  end
end
