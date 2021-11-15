class TimeEntry < ActiveRecord::Base
  include TimeEntryHelper
  
  belongs_to :time_sheet_entry

  class << self
    def clocks_in time_entry_event
      time_entry = TimeEntry.create(time_sheet_entry: time_entry_event)
      time_entry.event_type = 1
      time_entry.save
    end

    def clocks_out time_entry_event
      time_entry = time_entry_event.current_clock_in
      if time_entry 
        time_entry.event_date = Time.now
        time_entry.event_type = 0
        time_entry.save
      end
    end
  end
end
