class TimeSheetEntriesController < AuthenticationController
  before_action :admin_only, only: %i[create add_or_view_entries view_user_time_sheet]
  before_action :load_time_sheet_entry, only: %i[edit show update]
  before_action :load_time_sheet_of_current_user, only: [:clock_in_clock_out]
  def index
    @time_entry_event = @current_user.time_sheet_entry
    redirect_to new_time_sheet_entry_path if(@time_entry_event.nil?)
  end

  def show
  end

  def clock_in_clock_out
  end

  def new
    @time_entry_event = TimeSheetEntry.new
  end

  def create
    @time_entry_event = TimeSheetEntry.new(clock_event_params)
    @time_entry_event.user = current_user
    if @time_entry_event.save
      flash[:notice] = 'New Time Entry has been added'
      redirect_to time_sheet_entries_path
    else
      render 'new'
    end
  end

  def add_or_view_entries
    @users_with_time_sheet = TimeSheetEntry.find_users_with_time_sheet_entries(@current_user)
  end

  def view_user_time_sheet
    @user = User.find(params[:user][:id])
    @time_sheet_event = TimeSheetEntry.current_user_time_sheet_entry(@user.id) if @user.present?
  end

  def update
    if @time_entry_event.update(clock_event_params)
      flash[:notice] = "#{@time_entry_event.title} has been updated"
      redirect_to time_sheet_entries_path(@time_entry_event)
    else
      render :edit
    end
  end

  private

  def clock_event_params
    params.require(:time_sheet_entry).permit(:title, :description)
  end

  def load_time_sheet_entry
    @time_entry_event = TimeSheetEntry.preload(:time_entries).find(params[:id])
  end

  def load_time_sheet_of_current_user
    @time_entry_event = TimeSheetEntry.includes(:time_entries).find_by(user_id: @current_user.id)
  end
end
