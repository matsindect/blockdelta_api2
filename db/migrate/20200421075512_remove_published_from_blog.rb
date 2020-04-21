class RemovePublishedFromBlog < ActiveRecord::Migration[6.0]
  def change

    remove_column :blogs, :published, :boolean
  end
end
