class Competence < ApplicationRecord
  # These associations are not intended to be used directly but just to
  # facilitate the implications and suggestions associations.
  has_many :competence_associations
  has_many :associations, through: :competence_associations, source: :associated
  has_many :implication_associations, -> { implications }, source: :associated,
    class_name: 'CompetenceAssociation'
  has_many :suggestion_associations, -> { suggestions }, source: :associated,
    class_name: 'CompetenceAssociation'

  # These associations are intended to be used by other code to read and write
  # implication and suggestion associations.
  has_many :implications, source: :associated,
    through: :implication_associations, autosave: true
  has_many :suggestions, source: :associated, through: :suggestion_associations,
    autosave: true

  validates :value, presence: true, length: { maximum: 30 }
  default_scope { order('value ASC') }

  def transitive_associations(type, cs = [])
    send(type).each do |c|
      unless cs.include?(c)
        cs << c
        unless c.send(type).empty?
          c.transitive_associations(type, cs)
        end
      end
    end
    cs.reject { |c| c == self }
  end

  def transitive_implications
    transitive_associations(:implications)
  end

  def transitive_suggestions
    transitive_associations(:suggestions)
  end
end
