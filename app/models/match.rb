class Match < ApplicationRecord
  has_one :application, dependent: :destroy
  belongs_to :developer
  belongs_to :job
  validates_uniqueness_of :developer_id, :scope => :job_id
  validate :match_is_valid?
  enum status: [
    'Uncontacted',
    'Contacted',
    'Interested',
    'Applied to role',
    'Sent to Google Hire',
    'Rejected'
  ]

  delegate :status, to: :application, prefix: true, allow_nil: true
  delegate :full_name, to: :developer
  delegate :company_name, :company_url, :company_vetted?, to: :job
  delegate :title, to: :job, prefix: true
  delegate :developer_location, to: :developer

  def match_is_valid?
    if !developer.active_matched_jobs.include?(job)
      errors.add :match, 'No match between developer requirement and job requirement. Impossible to save match'
    end
  end
end
