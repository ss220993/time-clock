require 'rails_helper'

RSpec.describe TimeSheetEntriesController, type: :controller do
  before(:all) do
    RSpec::Mocks.with_temporary_scope do
      @user = FactoryGirl.create(:user)
      @time_entry_event_test = FactoryGirl.create(:time_sheet_entry, user: @user)
      @controller = TimeSheetEntriesController.new
    end
  end

  describe '#create time sheet' do
    it 'should return 200 response for valid request' do
      @controller.params = ActionController::Parameters.new({ title: 'title', description: 'desc' })
      @controller.params.permit!
      allow_any_instance_of(described_class).to receive(:create).and_return(true)
      @controller.send('create')
      expect(response.status).to be 200
    end
  end
end
