class CreateJobsmediauploads < ActiveRecord::Migration[6.0]
  def change
    create_table :jobsmediauploads do |t|
      t.references :jobsmedium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
