class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :food, null: false, foreign_key: true
      t.references :shopping_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
