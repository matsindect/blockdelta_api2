class AddSlugToBlogger < ActiveRecord::Migration[6.0]
  def change
    add_column :bloggers, :slug, :string
  end
end
