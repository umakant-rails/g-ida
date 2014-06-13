# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    answer "none of these"
    poll_id 1
  end
end
