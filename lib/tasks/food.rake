namespace :food do
  desc "calls food API and creates Food"
  task create_all: :environment do
    GetFoodService.new('breakfast').call
    GetFoodService.new('lunch').call
    GetFoodService.new('dinner').call
    GetFoodService.new('snack').call
  end
end
