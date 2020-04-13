class AddDetailsToBlogger < ActiveRecord::Migration[6.0]
  def change
    add_column :bloggers, :bio, :text
    add_column :bloggers, :interests, :string
    add_column :bloggers, :city, :text
    add_column :bloggers, :twitter, :text
    add_column :bloggers, :country, :text
    add_column :bloggers, :linkedin, :text
    add_column :bloggers, :facebook, :text
    add_column :bloggers, :instagram, :text
    add_column :bloggers, :medium_prof, :text
    remove_column :bloggers, :phone
    remove_column :bloggers, :profession
  end
end
