class Competence < ApplicationRecord
  has_many :competence_associations
  has_many :associations, through: :competence_associations, source: :associated
  has_many :category_associations, -> { categories }, source: :associated,
    class_name: 'CompetenceAssociation'
  has_many :categories, source: :associated, through: :category_associations,
    autosave: true
  has_many :suggestion_associations, -> { suggestions }, source: :associated,
    class_name: 'CompetenceAssociation'
  has_many :suggestions, source: :associated, through: :suggestion_associations,
    autosave: true
  validates :value, presence: true, length: { maximum: 30 }
  default_scope { order('value ASC') }
end
