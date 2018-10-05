class CreateJoinTableJobsCulturesAndBenefits < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :cultures, :cultures_legacy
    create_join_table :cultures, :jobs do |t|
      t.index :culture_id
      t.index :job_id
    end

    rename_column :jobs, :benefits, :benefits_legacy
    create_join_table :benefits, :jobs do |t|
      t.index :benefit_id
      t.index :job_id
    end

    all_cultures = Culture.all
    all_benefits = Benefit.all

    Job.all.map do |j|
      if j.cultures_legacy.present?
        j.culture_ids = []
        j.cultures_legacy.each do |c|
          the_culture = all_cultures.find_by_value(c)
          j.cultures.push(Culture.find(the_culture.id)) if the_culture
        end
      end
      if j.benefits_legacy.present?
        j.benefit_ids = []
        j.benefits_legacy.each do |c|
          the_benefit = all_benefits.find_by_value(c)
          j.benefits.push(Benefit.find(the_benefit.id)) if the_benefit
        end
      end
      j.save

      j.company.cultures = j.cultures if j.cultures.present?
      j.company.benefits = j.benefits if j.benefits.present?
      j.company.save
    end
  end
end
