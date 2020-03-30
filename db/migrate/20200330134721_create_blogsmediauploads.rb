class CreateBlogsmediauploads < ActiveRecord::Migration[6.0]
  def change
    create_table :blogsmediauploads do |t|
      t.references :blogsmedium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
