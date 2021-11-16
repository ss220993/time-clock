require 'rails_helper'

RSpec.describe TimeEntry, type: :model do
  describe '#create time entry' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @time_entry_event_test = FactoryGirl.create(:time_sheet_entry, user: @user)
    end

    it 'when time entry create is successful' do
      time_entry = FactoryGirl.build(:time_entry, time_sheet_entry: @time_entry_event_test)
      saved_time_entry = time_entry.save
      expect(saved_time_entry).to be true
    end

    it 'when time entry create is un successful' do
      time_entry = FactoryGirl.build(:time_entry, time_sheet_entry: nil)
      saved_time_entry = time_entry.save
      expect(saved_time_entry).to be false
    end

    it 'clocks out successfully' do
      time_entry = FactoryGirl.create(:time_entry, time_sheet_entry: @time_entry_event_test)
      TimeEntry.clocks_out(@time_entry_event_test)
      time_entry.reload
      expect(time_entry.event_date).not_to be nil
    end

    it 'clocks in successfully' do
      time_entry = FactoryGirl.create(:time_entry, time_sheet_entry: @time_entry_event_test)
      time_entry.event_date = nil
      time_entry.save
      TimeEntry.clocks_in(@time_entry_event_test)
      time_entry.reload
      expect(time_entry.event_date).to be nil
      expect(time_entry.event_type).to be 0
    end
  end
end
