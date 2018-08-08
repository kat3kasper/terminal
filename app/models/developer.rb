class Developer < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :applications, through: :matches
  has_one_attached :avatar
  has_many_attached :resumes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  geocoded_by :developer_location
  before_validation :email_downcase
  after_validation :geocode, on: :update
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :password_complexity
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }, on: :update
  validates :city, :country, :state, presence: true, if: :wants_office, on: :update
  validates :remote, inclusion: { in: [['remote'], ['office'], %w[remote office]] }, on: :update
  before_update :check_coordinates, if: :city_changed?
  before_update :set_mobility
  after_update :subscribe_developer_to_mailing_list

  DEFAULT_AVATAR = 'avatar.jpg'.freeze

  def avatar_thumbnail
    return DEFAULT_AVATAR unless avatar.attachment.present?
    avatar.variant combine_options: {
      resize: '300x300^', gravity: 'center', extent: '300x300'
    }
  end

  def developer_location
    [city, zip_code, state, country].compact.join(', ')
  end

  def wants_office
    remote != ['remote']
  end

  def set_mobility
    self.mobility = nil if full_mobility
  end

  def check_coordinates
    return unless latitude
    errors.add(:city, 'There is a problem with your location. Please try again')
  end

  def email_downcase
    email&.strip&.downcase
  end

  def set_url
    linkedin = "https://linkedin.com/in/#{linkedin_url}"
    github = "https://github.com/#{github_url}"
    self.github_url = self.github_url.empty? ? nil : github
    self.linkedin_url = self.linkedin_url.empty? ? nil : linkedin
  end

  def full_name
    first_name + ' ' + last_name if first_name && last_name
  end

  def password_complexity
    if !password.nil? && password !~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/
      errors.add :password, 'must include at least one lowercase letter, one uppercase letter, and one digit'
    end
  end

  def office_and_remote?
    remote.size == 2
  end

  def matched_job
    jobs = Job.active

    if office_and_remote? && !full_mobility
      jobs = jobs.remote_and_local_jobs(mobility, latitude, longitude)
    else
      jobs = jobs.remote_or_office_jobs(remote)
      if remote.include?('office') && !full_mobility
        jobs = jobs.check_location(mobility, latitude, longitude)
      end
    end

    jobs = need_us_permit ? jobs.can_sponsor : jobs

    jobs.match_skills_type(skills_array)
  end

  def check_for_first_matches
    matched_job.each do |job|
      Match.create(developer_id: id, job_id: job.id)
    end
  end

  def self.check_for_new_matches
    all.each do |developer|
      jobs_array = []
      new_matches = 0
      developer.matched_job.each do |job|
        match = Match.new(developer_id: developer.id, job_id: job.id)
        if match.save
          new_matches += 1
          jobs_array << job
        end
      end
      if new_matches.positive?
        DeveloperMailer.new_match_advise(developer, jobs_array.uniq).deliver
      end
    end
  end

  private

  def subscribe_developer_to_mailing_list
    SubscribeDeveloperToMailingListJob.perform_later(self)
  end
end
