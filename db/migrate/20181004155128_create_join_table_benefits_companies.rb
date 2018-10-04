class CreateJoinTableBenefitsCompanies < ActiveRecord::Migration[5.2]
  def change
    create_join_table :benefits, :companies do |t|
      t.index :benefit_id
      t.index :company_id
    end
  end
end
