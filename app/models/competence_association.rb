class CompetenceAssociation < ApplicationRecord
  belongs_to :competence
  belongs_to :associated, class_name: 'Competence'
  scope :implications, -> { where(strength: 'implication') }
  scope :suggestions, -> { where(strength: 'suggestion') }
end
