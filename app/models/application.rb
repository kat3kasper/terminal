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
end
