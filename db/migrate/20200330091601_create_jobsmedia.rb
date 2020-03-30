class CreateJobsmedia < ActiveRecord::Migration[6.0]
  def change
    create_table :jobsmedia do |t|
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
