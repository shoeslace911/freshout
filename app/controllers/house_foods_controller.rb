class HouseFoodsController < ApplicationController
  def index
  # pundit thing
    @house_foods = policy_scope(HouseFood)
    @foods = HouseFood.all
    @house = House.find(1)
  end

  def show
    @house_food = HouseFood.find(params[:id])
    authorize @house_food
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
