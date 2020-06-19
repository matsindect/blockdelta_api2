class AddColumnsToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :meta_decription, :string
    add_column :events, :image_alt, :string
    add_column :events, :meta_keywords, :string
  end
end
