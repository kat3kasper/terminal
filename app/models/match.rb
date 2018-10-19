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
  delegate :company_name, :company_url, :company_vetted?, :description,
           :cultures, :benefits, to: :job
  delegate :title, to: :job, prefix: true
  delegate :developer_location, to: :developer

  def match_is_valid?
    if !developer.active_matched_jobs.include?(job)
      errors.add :match, 'No match between developer requirement and job requirement. Impossible to save match'
    end
  end

  def self.remind_job_seekers_to_apply
    Developer.find_each do |developer|
      @matches_ids_array = []
      emails_to_send = 0
      developer.matches.
        where(reminder_sent: false).
        includes(:application).where(applications: {id: nil}).each do |match|
        if ((Time.now - match.created_at) / 1.day) >= 7
          @matches_ids_array << match.id
          emails_to_send =+ 1
        end
      end
      if emails_to_send.positive?
        DeveloperMailer.unapplied_matches_reminder(@matches_ids_array).deliver
        @matches_ids_array.each do |id|
          match = Match.find(id)
          match.update_attribute(:reminder_sent, true)
        end
      end
    end
  end
end
