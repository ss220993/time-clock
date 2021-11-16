class TimeEntry < ActiveRecord::Base
  include TimeEntryHelper
  
  belongs_to :time_sheet_entry

  class << self
    def clocks_in time_entry_event
      update_time_entry_event.call(1, nil, TimeEntry.create(time_sheet_entry: time_entry_event))
    end

    def clocks_out time_entry_event
      update_time_entry_event.call(0, Time.now, time_entry_event.current_clock_in)
    end

    private 

    def update_time_entry_event
      ->(event_type, event_date, time_entry) {
        if time_entry 
          time_entry.event_date = event_date
          time_entry.event_type = event_type
          time_entry.save
        end
      }
    end
  end
end
