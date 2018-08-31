class CreateCompetenceAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :competence_associations do |t|
      t.belongs_to :competence
      t.belongs_to :associated
      t.string :strength
      t.timestamps
      t.index [:competence_id, :associated_id], unique: true,
        name: 'primary_key'
    end
  end
end
