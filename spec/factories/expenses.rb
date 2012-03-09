# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    expense "Starbucks"
    amount 100
  end
end
