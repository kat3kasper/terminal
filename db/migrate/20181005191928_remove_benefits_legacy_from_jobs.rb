class RemoveBenefitsLegacyFromJobs < ActiveRecord::Migration[5.2]
  def change
    remove_column :jobs, :benefits_legacy, :text
    remove_column :jobs, :cultures_legacy, :text
  end
end
