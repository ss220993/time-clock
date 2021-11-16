require 'rails_helper'

RSpec.describe TimeSheetEntry, type: :model do
  describe '#create time entry' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'when time sheet entry create is successful' do
      time_entry = FactoryGirl.build(:time_sheet_entry, user: @user)
      saved_time_entry = time_entry.save
      expect(saved_time_entry).to be true
    end

    it 'when time entry create is un successful' do
      time_entry = FactoryGirl.build(:time_sheet_entry, user: @user)
      time_entry.title = nil
      saved_time_entry = time_entry.save
      expect(saved_time_entry).to be false
    end
  end
end
