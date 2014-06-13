# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "demouser@gmail.com"
    password "12345678"
    role_id 2
  end
  
  factory :admin_user, :parent => :user do
    email "adminuser@gmail.com"
    password "12345678"
    role_id 1
  end

  factory :member_user, :parent => :user do
    role_id 2 
  end

end
