class TimeSheetEntry < ActiveRecord::Base
  include TimeSheetEntryHelper
  has_many :time_entries, -> { order 'created_at' }
  belongs_to :user
  accepts_nested_attributes_for :user
  
  scope :current_user_time_sheet_entry,->(user) { where('user_id = ?', user) }

  validates :title, presence: true
  validates :description, presence: true

  class << self
    def find_users_with_time_sheet_entries(current_user)
      preload(:user).where("user_id is NOT NULL AND user_id <> ?", current_user.id).map(&:user)
    end
  end

  def current_clock_in
    time_entries.last
  end

  def currently_clocked_in?
    clocked_in = current_clock_in
    clocked_in.present? && clocked_in.event_type == 1
  end
end
