FactoryGirl.define do
    factory :time_entry, class: TimeEntry do
        association :time_sheet_entry, factory: :time_sheet_entry
        event_type 0
        event_date Time.now
    end
end