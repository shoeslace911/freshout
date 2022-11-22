class HouseFoodsController < ApplicationController
  def index
  end

  def show
    @house_food = HouseFood.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
