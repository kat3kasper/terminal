class RenameJobsCulturesAndBenefits < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :cultures, :cultures_legacy
    rename_column :jobs, :benefits, :benefits_legacy

    all_cultures = Culture.all
    all_benefits = Benefit.all

    Job.all.map do |j|
      if j.company
        if j.cultures_legacy.present?
          j.company.culture_ids = []
          j.cultures_legacy.each do |c|
            the_culture = all_cultures.find_by_value(c)
            j.company.cultures.push(Culture.find(the_culture.id)) if the_culture
          end
        end
        if j.benefits_legacy.present?
          j.company.benefit_ids = []
          j.benefits_legacy.each do |c|
            the_benefit = all_benefits.find_by_value(c)
            j.company.benefits.push(Benefit.find(the_benefit.id)) if the_benefit
          end
        end
        j.company.save
      end
    end
  end
end
