class CreateTimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_entries, id: :uuid do |t|
      t.integer :event_type
      t.uuid :time_sheet_entry_id
      t.datetime :event_date
      t.string :timezone
      t.timestamps
    end
    add_index :time_entries, [:event_type]
    add_index :time_entries, [:event_date]
    add_foreign_key :time_entries, :time_sheet_entries
  end
end
