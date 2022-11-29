class AddSeenToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :seen, :boolean, default: false, null: false
  end
end
