class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :recruiters, dependent: :nullify
  has_many_attached :images
  has_one :subscriber, -> { order created_at: :desc }, dependent: :destroy
  has_and_belongs_to_many :cultures
  has_and_belongs_to_many :benefits
  validates_presence_of :benefits, message: 'You must select at least 1 benefit'
  validates_presence_of :cultures, message: 'You must select at least 1 culture'

  validates :name, :url, presence: true, length: { maximum: 500 }

  delegate :active?, :canceled?, :subscription_expires_at, :plan_name,
    to: :subscriber, allow_nil: true

  def self.active
    vetted = self.where(vetted: true).pluck :id
    active = self.left_outer_joins(:subscriber).where(subscribers: {status: :active}).pluck :id
    almost_canceled = self.left_outer_joins(:subscriber).where(subscribers: {status: :canceled, subscription_expires_at: Date.today..10.years.from_now}).pluck :id
    self.where(id: (vetted + active + almost_canceled).compact)
  end

  def applications
    job_ids = jobs.pluck(:id)
    matches_ids = Match.where(job_id: job_ids).pluck(:id)
    Application.where(match_id: matches_ids)
  end

  def recruiters_mail
    recruiters.pluck(:email).flatten.uniq
  end

  def is_active?
    vetted? or (active? or (canceled? and subscription_expires_at >= Date.today))
  end

  def max_active_jobs
    return 1e6 if vetted?

    case subscriber.try(:plan).try(:stripe_id)
    when '1-job'
      1
    when '3-jobs'
      3
    end
  end

  def can_add_job?
    is_active? and jobs.active.count < max_active_jobs
  end

  def is_member?
    subscriber.present? && (
      subscriber.active? || (
        subscriber.canceled? && subscriber.subscription_expires_at >= Date.today
      ) || subscriber.trialing? || subscriber.past_due?
    )
  end

  def active_jobs
    @active_jobs ||= jobs.where(active: true)
  end

  def inactive_jobs
    @inactive_jobs ||= jobs.where(active: false)
  end
end
