FactoryBot.define do
  factory :report do
    association :reported, factory: :user
    association :reporter, factory: :user
    check { false }  
  end
end

