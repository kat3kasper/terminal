class BenefitCompany < ApplicationRecord
  self.table_name = 'benefits_companies'
  belongs_to :company
  belongs_to :benefit
end
