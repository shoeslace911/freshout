namespace :food do
  desc "calls food API and creates Food"
  task create_all: :environment do
    Food.destroy_all
    GetFoodService.new('breakfast').call
  end

end
