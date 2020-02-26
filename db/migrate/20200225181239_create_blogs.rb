class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.boolean :published, null: false, default: 'user'
      t.belongs_to :user
      t.belongs_to :sector
      t.belongs_to :category
      t.datetime :published_at
      t.timestamps
    end
  end
end
