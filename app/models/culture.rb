class Culture < ApplicationRecord
  has_many :company_cultures
  has_many :companies, through: :company_cultures
end
