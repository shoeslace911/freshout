class HouseFoodsController < ApplicationController
  def index
    if params[:query].present?
      @foods = policy_scope(HouseFood).search_for_name_and_category(params[:query]).order("expiry_date")
      @searched_food = Food.find_by('name ILIKE ?', "%#{params[:query]}%")
    else
      @foods = policy_scope(HouseFood).order("expiry_date")
    end
    flash.delete(:alert)
    if session[:bought_foods].size > 0
      flash[:alert] = "#{session[:bought_foods].size} foods added to kitchen"
      session[:bought_foods] = []
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "house_foods/cards", locals: { foods: @foods }, formats: [:html] }
    end
    @item = Item.new
  end

  def show
    @house_food = HouseFood.find(params[:id])
    @item = Item.new
    @food = @house_food.food
    authorize @house_food
  end

  def new
    @house_food = HouseFood.new
    authorize @house_food
    @foods = Food.order("name")
    # @foods.
  end

  def create
    # if the create is coming from the shopping list
    # otherwise, the food is submitted in the form
    if from_shopping_list?
      food = Food.find(params[:food_id])
      food.add_expiry
      @house_food = HouseFood.new(
        food: food,
        bought_date: Date.today,
        expiry_date: Date.today + food.expiry_days,
        house: current_user.house,
        owned: true,
        amount: params[:amount].to_i
      )

    else
      @house_food = HouseFood.new(house_food_params)
    end
    @house_food.house = current_user.house
    # can make user modify?
    food = @house_food.food
    food.add_expiry
    @house_food.expiry_date = @house_food.bought_date + food.expiry_days
    authorize @house_food
    # this is when the food is created from inventory
    if from_shopping_list? && @house_food.save
      item = Item.find(params[:item_id].to_i)
      item.destroy
      redirect_to house_foods_path
    elsif @house_food.save

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

  def update
    @house_food = HouseFood.find(params[:id])
    authorize @house_food
    @house_food.update(scanned_params)
  end

  def eat
    @house_food = HouseFood.find(params[:id])
    @house_food.amount -= 1
    authorize @house_food
    redirect_to house_food_path(@house_food) if @house_food.save
  end

  def add
    @house_food = HouseFood.find(params[:id])
    @house_food.expiry_date += 3
    authorize @house_food
    redirect_to house_food_path(@house_food) if @house_food.save
  end

  def scan
    # house_food = HouseFood.new
    # authorize house_food
    uploading_picture = Cloudinary::Uploader.upload(params[:photo].path)
    @lines = Ocr.extract_text(uploading_picture["secure_url"])
    @foods = Food.all
    mapped_foods = @foods.map do |food|
      food.name.downcase
    end
    bought_foods = []
    @lines.each do |line|
      # puts line.downcase
      if mapped_foods.include?(line.downcase)
        food = Food.where('name ILIKE ?', "#{line.downcase}").first
        bought_foods.push(food)
      end
    end
    session[:bought_foods] = bought_foods
    @scanned_house_foods = []
    bought_foods.each do |bought_food|
      house_food = HouseFood.new(
        food_id: bought_food.id,
        amount: 1,
        bought_date: Date.today,
        expiry_date: bought_food.expiry_days ? Date.today + bought_food.expiry_days : Date.today + 7,
        house: current_user.house,
        owned: true
      )
      authorize house_food
      house_food.save
      @scanned_house_foods << house_food
    end
    # bought_foods
    current_user.house.shopping_lists.first.items.each do |item|
      # item_array << item.food
      item.destroy if bought_foods.include?(item.food)
    end
    render :scanned_items
  end
  # def update_all
  #   raise
  # end

  private

  def house_food_params
    params.require(:house_food).permit(:food_id, :amount, :bought_date, :expiry_date, :measurement)
  end

  def from_shopping_list?
    params[:food_id].present?
  end

  def scanned_params
    params.require(:house_food).permit(:amount, :measurement, :expiry_date)
  end
end
