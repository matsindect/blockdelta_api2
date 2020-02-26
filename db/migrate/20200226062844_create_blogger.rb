class CreateBlogger < ActiveRecord::Migration[6.0]
  def change
    create_table :bloggers do |t|
      t.string :first_name
      t.string :surname
      t.string :profession
      t.string :phone
      t.belongs_to :user
      t.belongs_to :profile
      t.timestamps
    end
  end
end
