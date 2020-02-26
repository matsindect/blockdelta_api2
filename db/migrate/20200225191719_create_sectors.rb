class CreateSectors < ActiveRecord::Migration[6.0]
  def change
    create_table :sectors do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.timestamps
    end
  end
end
