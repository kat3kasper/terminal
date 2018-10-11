# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :company
  has_many :matches, dependent: :destroy
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :developers, through: :matches
  has_many :applications, through: :matches
  has_many :application_matches, through: :applications, source: :match
  has_many :applied_developers, through: :application_matches, source: :developer
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 10_000 }
  validates :city, :state, :country, presence: true, length: { maximum: 100 }
  validates :max_salary, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :remote, inclusion: { in: [['remote'], ['office'], ['remote', 'office']] }
  validates :employment_type, presence: true, length: { maximum: 100 }
  geocoded_by :location
  before_validation :geocode, if: -> { latitude.nil? }
  validate :check_coordinates, on: [:create, :update]

  before_validation :sanitize_description

  delegate :name, :url, :vetted?, to: :company, prefix: true
  delegate :benefit_ids, :benefits, :culture_ids, :cultures, to: :company

  scope :active, -> { where(active: true, company: Company.active) }

  scope :remote_and_local_jobs, ->(miles, lat, long) {
    where(id: (Job.all_remote.pluck(:id) +
               Job.check_location(miles, lat, long).pluck(:id)).uniq)
  }
  scope :remote_or_office_jobs, ->(array) {
    where('remote <@ ARRAY[?]::text[] OR remote @> ARRAY[?]::text[]', array, array)
  }
  scope :can_sponsor, -> { where(can_sponsor: true) }
  scope :match_skills_type, ->(array) {
    where.not(skills_array: []).where('skills_array <@ ARRAY[?]::text[]', array)
  }
  scope :filter_by_salary, ->(value) { where('max_salary >= ?', value) }
  scope :filter_by_companies, ->(array) {
    where(company_id: array)
  }
  scope :filter_by_employment_type, ->(value) {
    where('employment_type = ?', value)
  }
  scope :filter_by_city, ->(array) { where(city: array) }
  scope :order_by_vetted, -> { order(vetted: :desc) }

  scope :all_remote, -> { where("'remote' = ANY (remote)") }

  def self.check_location(miles, lat, long)
    if lat.present?
      geocoded.near([lat, long], miles, units: :mi).unscope(:order)
    else
      all
    end
  end

  def location
    [city, zip_code, state, country].compact.join(', ')
  end

  def deactivate
    self.active = false
  end

  def sanitize_description
    Sanitize.fragment(self.description, Sanitize::Config::BASIC)
  end

  def check_coordinates
    location_error = 'There is a problem with your location. Please try again'
    errors.add(:city, location_error) if latitude.nil?
  end

  def toggle_to_vetted
    self.vetted = true if company.vetted?
  end

  def office_and_remote?
    remote.size == 2
  end

  def matched_devs
    if office_and_remote?
      devs = Developer.match_location_or_remote(latitude, longitude)
    elsif remote == ['remote']
      devs = Developer.all_remote
    elsif remote == ['office']
      devs = Developer.all_office.match_location(latitude, longitude)
    end

    devs = can_sponsor ? devs : devs.where(need_us_permit: false)

    devs.match_skills_type(skills_array)
  end

  def has_applicant? developer
    applied_developers.include? developer
  end
end
