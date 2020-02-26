class CreateProfile < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.timestamps
    end
  end
end
