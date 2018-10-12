class Benefit < ApplicationRecord
  has_many :benefit_companies
  has_many :companies, through: :benefit_companies
end
