class CreateKhmerCalendars < ActiveRecord::Migration[8.0]
  def change
    create_table :khmer_calendars do |t|
      t.integer   :year,                null: false, limit: 2
      t.string    :khmer_calendar_text, null: false, limit: 150
      t.timestamps
    end
  end
end
