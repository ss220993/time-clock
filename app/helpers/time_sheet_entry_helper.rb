module TimeSheetEntryHelper
  def show_previous_if_any
    time_entries.any? && time_entries.last.present?
  end

  def total_time_on_clock_event
    total = 0
    time_entries.each do |clock|
      next unless clock.event_date.present?

      clock_in_time = clock.created_at
      clock_out_time = clock.event_date
      total_time = clock_out_time - clock_in_time
      total += total_time
    end
    total
  end
end
