class CreateJoinTableCompanyCulture < ActiveRecord::Migration[5.2]
  def change
    create_join_table :companies, :cultures do |t|
      t.index :company_id
      t.index :culture_id
    end
  end
end
