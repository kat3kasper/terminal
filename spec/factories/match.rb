FactoryBot.define do
  factory :match do
    job
    developer
    status 0
    reminder_sent false

    trait :expired do
      after :create do |match|
        match.created_at = Date.new(2012, 3, 6)
      end
    end
  end
end
