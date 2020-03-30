class CreateEventsmediauploads < ActiveRecord::Migration[6.0]
  def change
    create_table :eventsmediauploads do |t|
      t.references :eventsmedium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
