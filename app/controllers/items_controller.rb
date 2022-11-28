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
    @foods = Food.order("name")
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.shopping_list = current_user.house.shopping_lists.first
    @item.user = current_user
    authorize @item
    if params[:item]
      @item.amount = params[:item][:amount]
      @item.food = Food.find(params[:item][:food_id])
      @item.comment = params[:item][:comment]
      if @item.save
        redirect_to shopping_list_path(@item.shopping_list)
      else
        render :new, status: :unprocessable_entity
      end
    else
      @item.amount = 1
      @item.food = Food.find(params[:food_id])
      @item.save
    end
  end

  private

  def item_params
    # params.require(:item).permit(:food_id, :amount, :measurement)
    params.permit(:food_id, :comment)
  end
end
