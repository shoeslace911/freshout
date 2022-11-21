class AddUsernameAndReferenceToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_reference :users, :house, null: false, foreign_key: true
  end
end
