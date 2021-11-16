FactoryGirl.define do
    factory :time_sheet_entry, class: TimeSheetEntry do
      association :user, factory: :user
      title 'title'
      description 'description'
    end
end