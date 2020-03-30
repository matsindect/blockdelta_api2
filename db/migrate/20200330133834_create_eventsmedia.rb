class CreateEventsmedia < ActiveRecord::Migration[6.0]
  def change
    create_table :eventsmedia do |t|

      t.timestamps
    end
  end
end
