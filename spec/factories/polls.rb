# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :poll do
    title = "test cases executed successfully?"
    #FactoryGirl.nested_attributes_for(:poll)
  end
end

