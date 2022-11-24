class RemoveHouseFoodFromShoppingLists < ActiveRecord::Migration[7.0]
  def change
    remove_reference :shopping_lists, :house_food, null: false, foreign_key: true
  end
end
