class AddMeasurementToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :measurement, :string
  end
end
