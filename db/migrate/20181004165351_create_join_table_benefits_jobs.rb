class CreateJoinTableBenefitsJobs < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :benefits, :benefits_legacy
    create_join_table :benefits, :jobs do |t|
      t.index :benefit_id
      t.index :job_id
    end

    all_benefits = Benefit.all
    Job.all.map do |j|
      if j.benefits_legacy.present?
        j.benefit_ids = []
        j.benefits_legacy.each do |c|
          the_benefit = all_benefits.find_by_value(c)
          j.benefits.push(Benefit.find(the_benefit.id)) if the_benefit
        end
        j.save

        if j.benefits.present?
          j.company.benefits = j.benefits
          j.company.save
        end
      end
    end
  end
end
