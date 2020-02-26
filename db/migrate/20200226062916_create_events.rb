class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :event_start_date
      t.datetime :event_end_date
      t.string :event_title
      t.text :event_description
      t.string :event_venue
      t.string :website
      t.belongs_to :category
      t.belongs_to :sector
      t.belongs_to :user
      t.datetime :published_at
      t.timestamps
    end
  end
end
