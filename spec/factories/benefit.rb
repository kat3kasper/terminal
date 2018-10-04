FactoryBot.define do
  factory :benefit do
    value { Faker::Food.fruits }
  end
end
