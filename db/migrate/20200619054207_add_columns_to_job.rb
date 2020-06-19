class AddColumnsToJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :meta_decription, :string
    add_column :jobs, :image_alt, :string
    add_column :jobs, :meta_keywords, :string
  end
end
