class HouseFoodsController < ApplicationController
  def index
    @house_foods = policy_scope(HouseFood)
    @foods = HouseFood.all
    @house = House.find(2)
    # Changed it to 2 to test out something can return to 1 if you want
  end

  def show
    @house_food = HouseFood.find(params[:id])
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
      raise
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def house_food_params
    params.require(:house_food).permit( :food_id, :amount, :photo, :bought_date, :expiry_date)
  end

end
