class CompanyCulture < ApplicationRecord
  self.table_name = 'companies_cultures'
  belongs_to :company
  belongs_to :culture
end
