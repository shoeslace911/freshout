class HouseFoodsController < ApplicationController
  def index
    @foods = HouseFood.all
    @house = House.find(1)
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
