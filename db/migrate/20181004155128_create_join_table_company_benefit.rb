class CreateJoinTableCompanyBenefit < ActiveRecord::Migration[5.2]
  def change
    create_join_table :companies, :benefits do |t|
      t.index :company_id
      t.index :benefit_id
    end
  end
end
