class AddAuthorSlugToBlog < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :author_slug, :string
  end
end
