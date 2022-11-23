class HouseFoodsController < ApplicationController
  def index
  @foods = policy_scope(HouseFood)
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
    @house_food = HouseFood.new(house_food_params)
    food = Food.find(house_food_params[:food_id])
    @house_food.food = food
    @house_food.house = current_user.house
    authorize @house_food
    if @house_food.save
      redirect_to house_foods_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @house_food = HouseFood.find(params[:id])
    authorize @house_food
    @house_food.destroy
    redirect_to house_foods_path
  end

  def eat
    @house_food = HouseFood.find(params[:id])
    @house_food.amount -= 1
    authorize @house_food
    if @house_food.save
      redirect_to house_food_path(@house_food)
    end
  end

  private

  def house_food_params
    params.require(:house_food).permit( :food_id, :amount, :photo, :bought_date, :expiry_date)
  end
end
