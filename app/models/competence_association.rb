class CompetenceAssociation < ApplicationRecord
  belongs_to :competence
  belongs_to :associated, class_name: 'Competence'
  scope :categories, -> { where(strength: 'category') }
  scope :suggestions, -> { where(strength: 'suggestion') }
end
