class Application < ApplicationRecord
  enum status: [ :pending, :opened, :contacted, :rejected ]

  belongs_to :match
  has_one :developer, through: :matches
  has_one :job, through: :matches
  has_one :company, through: :job
  validates :message, length: { maximum: 8000 }

  scope :open, -> { where.not(status: :rejected) }

  delegate :job, :developer, to: :match, allow_nil: true
  delegate :company, to: :job, allow_nil: true
  delegate :title, to: :job, prefix: true, allow_nil: true
  delegate :recruiters_mail, to: :company, allow_nil: true
  delegate :name, to: :company, prefix: true, allow_nil: true
  delegate :full_name, to: :developer, prefix: true, allow_nil: true

  def self.remind_companies_to_review
    Company.find_each do |company|
      @application_ids_array = []
      emails_to_send = 0
      company.applications.where(status: ["pending", "opened"]).each do |app|
        if ((Time.now - app.last_mail_sent) / 1.day) >= 7
          @application_ids_array << app.id
          emails_to_send =+ 1
        end
      end
      if emails_to_send.positive?
        CompanyMailer.application_review_reminder(@application_ids_array).deliver
        @application_ids_array.each do |id|
          application = Application.find(id)
          application.update_attribute(:last_mail_sent, Time.now)
        end
      end
    end
  end
end
