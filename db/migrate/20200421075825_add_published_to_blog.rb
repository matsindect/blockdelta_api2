class AddPublishedToBlog < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :published, :boolean, null: false, default: false
  end
end
