class CreateBlogsmedia < ActiveRecord::Migration[6.0]
  def change
    create_table :blogsmedia do |t|

      t.timestamps
    end
  end
end
