class TimeEntriesController < AuthenticationController
  
  before_action :get_time_sheet_entry

  def clock_in
    clocks_in = TimeEntry.clocks_in(@time_entry_event)
    if clocks_in
      flash[:notice] = "You have clocked In Successfully"
      redirect_to root_path
      
      #Todo
      #Handle when not saved properly
    end
  end

  def clock_out
    clocks_out = TimeEntry.clocks_out(@time_entry_event)
    if clocks_out
      flash[:notice] = "You have clocked out of #{@time_entry_event.title}"
      redirect_to root_path
    else
      flash[:error] = "You are not clocked in to #{@time_entry_event.title}, so you can't clock out."
      redirect_to time_sheet_entries_path(@time_entry_event)
    end
  end

  private

  def get_time_sheet_entry
    @time_entry_event = TimeSheetEntry.includes(:time_entries).find(params.permit(:id))
  end
end
