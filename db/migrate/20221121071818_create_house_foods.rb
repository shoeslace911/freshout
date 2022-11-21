class CreateHouseFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :house_foods do |t|
      t.references :food, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true
      t.date :expiry_date
      t.date :bought_date
      t.text :comment
      t.integer :amount
      t.boolean :owned

      t.timestamps
    end
  end
end
