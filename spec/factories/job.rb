FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description "<p>THere are some things you can do</p>"
    city "Loveland"
    zip_code nil
    state "CO"
    country "United States"
    active true
    remote ["remote"]
    latitude 40.3977612
    longitude -105.0749801
    max_salary 50000
    skills_array ["apache/1", "android/3"]
    employment_type "Part-Time"
    can_sponsor false
    association :company, :active
    benefits { company.benefits }
    cultures { company.cultures }

    trait :remote do
      remote ["remote"]
    end

    trait :office do
      remote ["office"]
    end

    trait :remote_and_office do
      remote ["remote", "office"]
    end
  end
end
