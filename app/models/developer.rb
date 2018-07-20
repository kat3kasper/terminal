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
  before_validation :capitalize_name
  after_validation :geocode, on: :update
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :password_complexity
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }, on: :update
  validates :city, :country, :state, presence: true, if: :wants_office, on: :update
  validates :remote, inclusion: { in: [['remote'], ['office'], %w[remote office]] }, on: :update
  before_update :check_cordinates, if: :city_changed?
  before_update :set_mobility

  DEFAULT_AVATAR = "avatar.jpg"

  def avatar_thumbnail
   return DEFAULT_AVATAR unless avatar.attachment.present?
   avatar.variant combine_options: {resize: "300x300^", gravity: "center", extent: "300x300"}
  end

  def developer_location
    [city, zip_code, state, country].compact.join(', ')
  end

  def wants_office
    self.remote != ['remote']
  end

  def set_mobility
    self.mobility = nil if full_mobility
  end

  def check_cordinates
    errors.add(:city, "There is a problem with your location. Please try again") if !latitude
  end

  def email_downcase
    email = email.strip.downcase if email
  end

  def capitalize_name
    first_name = first_name.capitalize if first_name
    last_name = last_name.capitalize if last_name
  end


  def set_url
    linkedin = "https://linkedin.com/in/#{linkedin_url}"
    github = "https://github.com/#{github_url}"
    self.github_url.empty? ? self.github_url = nil : self.github_url = github
    self.linkedin_url.empty? ? self.linkedin_url = nil : self.linkedin_url = linkedin
  end

  # def first_login
  #   self.first_login = true
  # end

  def full_name
    first_name.capitalize + " " + last_name.capitalize if first_name && last_name
  end


  def password_complexity
    if !password.nil? && password !~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/
      errors.add :password, 'Password must include at least one lowercase letter, one uppercase letter, and one digit'
    end
  end

  def matched_job
    if remote === ["remote"]
      Job.active.remote_or_office_jobs(remote).match_skills_type(skills_array)
    else
      if full_mobility
        Job.active.remote_or_office_jobs(remote).match_skills_type(skills_array)
      else
        jobs_near_me = Job.active.check_location(mobility, latitude, longitude).remote_or_office_jobs(remote)

        if remote.include?("remote")
          jobs_remote = Job.active.remote_or_office_jobs(["remote"]).match_skills_type(skills_array)
          jobs = jobs_near_me + jobs_remote
        else
          jobs = jobs_near_me
        end

        if need_us_permit
          jobs.can_sponsor
        else
          jobs
        end
      end
    end

  end


  def check_for_first_matches
    self.matched_job.each do |job|
      Match.create(developer_id: self.id, job_id: job.id)
    end
  end


  def self.check_for_new_matches
    string = ''
    jobs_array = []
    all.each do |developer|
      new_matches = 0
      developer.matched_job.each do |job|
        match = Match.new(developer_id: developer.id, job_id: job.id)
        if match.save
          new_matches += 1
          jobs_array << job
        end
      end
      if new_matches > 0
        DeveloperMailer.new_match_advise(developer, jobs_array.uniq).deliver
      end
    end
  end

end
