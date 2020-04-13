class RemoveProfileIdFromBlogger < ActiveRecord::Migration[6.0]
  def change
    remove_column :bloggers, :profile_id
  end
end
