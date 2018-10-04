FactoryBot.define do
  factory :culture do
    value { Faker::Company.buzzword }
  end
end
