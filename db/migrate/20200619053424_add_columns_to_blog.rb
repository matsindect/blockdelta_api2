class AddColumnsToBlog < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :meta_decription, :string
    add_column :blogs, :image_alt, :string
    add_column :blogs, :meta_keywords, :string
  end
end
