# frozen_string_literal: true
module TimeEntryHelper
  TIME_FORMAT = '%l:%M:%S%p'
  DATE_FROMAT = '%B %d, %Y'
  DATE_TIME_FORMAT = '%l:%M:%S%p %Z on %B %d, %Y'
  H_M_S_FORMAT = '%04d:%02d:%02d'
  
  def log_in_date(clock_created_at)
    clock_created_at.strftime(DATE_FROMAT)
  end

  def log_in_time(clock_created_at)
    clock_created_at.strftime(TIME_FORMAT)
  end

  def log_out_time(clock_out_at)
    clock_out_at && clock_out_at.strftime(TIME_FORMAT)
  end

  def format_datetime(date)
    date && date.strftime(DATE_TIME_FORMAT)
  end

  def format_total_time(time)
    hours = time / (60 * 60)
    minutes = (time / 60) % 60
    seconds = time % 60
    format(H_M_S_FORMAT, hours, minutes, seconds)
  end

  def time_on_clock
    if event_date.present?

      clock_in_time = created_at
      clock_out_time = event_date

      total_time = clock_out_time - clock_in_time

      seconds = total_time % 60
      minutes = (total_time / 60) % 60
      hours = total_time / (60 * 60)

      format(H_M_S_FORMAT, hours, minutes, seconds)
    end
  end
end
