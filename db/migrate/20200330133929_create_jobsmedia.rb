class CreateJobsmedia < ActiveRecord::Migration[6.0]
  def change
    create_table :jobsmedia do |t|

      t.timestamps
    end
  end
end
