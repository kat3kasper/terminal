FactoryBot.define do
  factory :competence do
    value { Faker::Job.key_skill }

    trait :with_implication do
      after :create do |c|
        c.implications << FactoryBot.create(:competence)
        c.save!
      end
    end

    trait :with_transitive_implications do
      after :create do |c|
        c1 = FactoryBot.create(:competence)
        c2 = FactoryBot.create(:competence)
        c2.implications << c1
        c2.save!
        c.implications << c2
        c.save!
      end
    end

    trait :with_suggestion do
      after :create do |c|
        c.suggestions << FactoryBot.create(:competence)
        c.save!
      end
    end

    trait :with_transitive_suggestions do
      after :create do |c|
        c1 = FactoryBot.create(:competence)
        c2 = FactoryBot.create(:competence)
        c2.suggestions << c1
        c2.save!
        c.suggestions << c2
        c.save!
      end
    end
  end
end
