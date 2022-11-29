class AddExpiryDaysToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :expiry_days, :integer
  end
end
