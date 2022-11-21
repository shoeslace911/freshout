class CreateShoppingLists < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_lists do |t|
      t.references :house, null: false, foreign_key: true
      t.references :house_food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
