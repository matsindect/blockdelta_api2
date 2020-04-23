class RemoveCategoryIdFromEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :category_id
  end
end
