require 'rails_helper'

RSpec.describe Competence, type: :model do
  let(:unassociated_competence) { create :competence }
  let(:categorized_competence) { create :competence, :with_implication }
  let(:competence_with_suggestion) { create :competence, :with_suggestion }
  let(:competence_with_transitive_implications) {
    create :competence, :with_transitive_implications
  }
  let(:competence_with_transitive_suggestions) {
    create :competence, :with_transitive_suggestions
  }

  context 'with no associations' do
    it 'has no implications nor suggestions' do
      expect(unassociated_competence.implications).to be_empty
      expect(unassociated_competence.suggestions).to be_empty
    end
  end

  context 'with one implication' do
    it 'has one implication and no suggestions' do
      expect(categorized_competence.implications.size).to eq(1)
      expect(categorized_competence.suggestions).to be_empty
    end
  end

  context 'with one suggestion' do
    it 'has no implications but one suggestion' do
      expect(competence_with_suggestion.implications).to be_empty
      expect(competence_with_suggestion.suggestions.size).to eq(1)
    end
  end

  context 'with transitive implications' do
    it 'returns all implications from #transitive_implications' do
      expect(competence_with_transitive_implications.transitive_implications.size
            ).to eq(2)
    end
  end

  context 'with transitive suggestions' do
    it 'returns all suggestions from #transitive_suggestions' do
      expect(competence_with_transitive_suggestions.transitive_suggestions.size
            ).to eq(2)
    end
  end
end
