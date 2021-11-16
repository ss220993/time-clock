require 'rails_helper'

RSpec.describe TimeEntriesController, type: :controller do
  before(:all) do
    RSpec::Mocks.with_temporary_scope do
      @user = FactoryGirl.create(:user)
      @time_entry_event_test = FactoryGirl.create(:time_sheet_entry, user: @user)
      @time_entry = FactoryGirl.create(:time_entry, time_sheet_entry: @time_entry_event_test)
      @controller = TimeEntriesController.new
    end
  end

  describe '#create time entry' do
    it 'should return 200 response for valid request when clocks in' do
      @controller.params = ActionController::Parameters.new({ id: @time_entry_event_test.id })
      @controller.params.permit!
      allow_any_instance_of(described_class).to receive(:clock_in).and_return(true)
      @controller.send('clock_in')
      expect(response.status).to be 200
    end

    it 'should return 200 response for valid request when clocks out' do
      @controller.params = ActionController::Parameters.new({ id: @time_entry_event_test.id })
      @controller.params.permit!
      allow_any_instance_of(described_class).to receive(:clock_out).and_return(true)
      @controller.send('clock_out')
      expect(response.status).to be 200
    end
  end
end
