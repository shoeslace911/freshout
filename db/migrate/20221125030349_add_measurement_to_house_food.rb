class AddMeasurementToHouseFood < ActiveRecord::Migration[7.0]
  def change
    add_column :house_foods, :measurement, :string
  end
end
