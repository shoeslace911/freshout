class HouseFoodsController < ApplicationController
  def index
    @house_foods = policy_scope(HouseFood)
  end

  def show
    @house_food = HouseFood.find(params[:id])
  end

  def new
    @house_food = HouseFood.new
    authorize @house_food
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

end
