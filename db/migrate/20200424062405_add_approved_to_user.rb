class AddApprovedToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :approved, :boolean, null: false, default: false
    add_column :users, :approved_at, :datetime
  end
end
