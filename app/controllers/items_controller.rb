class ItemsController < ApplicationController
  def destroy
    @item = Item.find(params[:id])
    authorize @item
    if @item.destroy
      redirect_to shopping_list_path(current_user.house.shopping_lists.first)
    else
      render shopping_list_path(current_user.house.shopping_lists.first), status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.shopping_list = current_user.house.shopping_lists.first
    @item.amount = 1
    authorize @item
    @item.save
  end

  private

  def item_params
    params.permit(:food_id)
  end
end
