class CreateJoinTableCulturesJobs < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :cultures, :cultures_legacy
    create_join_table :cultures, :jobs do |t|
      t.index :culture_id
      t.index :job_id
    end

    all_cultures = Culture.all
    Job.all.map do |j|
      if j.cultures_legacy.present?
        j.culture_ids = []
        j.cultures_legacy.each do |c|
          the_culture = all_cultures.find_by_value(c)
          j.cultures.push(Culture.find(the_culture.id)) if the_culture
        end
        j.save

        if j.cultures.present?
          j.company.cultures = j.cultures
          j.company.save
        end
      end
    end
  end
end
