class AddAuthorNameToBlog < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :author_name, :text
    add_column :blogs, :author_surname, :text
  end
end
