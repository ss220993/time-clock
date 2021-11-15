class TimeEntryService

    def initialize(time_sheet_entry:, flash:)
        @time_sheet_entry = time_sheet_entry
        @flash = flash
      end
    
      def user_clocks_in
        TimeEntry.create(time_sheet_entry: @time_entry_event).save
      end
end
