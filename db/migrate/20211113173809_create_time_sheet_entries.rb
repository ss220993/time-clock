class CreateTimeSheetEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_sheet_entries, id: :uuid do |t|
      t.string :title
      t.text :description
      t.uuid :user_id
      t.string :timezone
      t.timestamps
    end
    add_foreign_key :time_sheet_entries, :users
  end
end
