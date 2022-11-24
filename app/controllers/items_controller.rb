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
end
