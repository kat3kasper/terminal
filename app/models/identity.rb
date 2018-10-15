class Identity < ApplicationRecord
  belongs_to :developer

  def self.find_for_oauth(auth)
    identity = Identity.where(provider: auth.provider, uid: auth.uid).first
    if identity.nil?
      registered_developer = Developer.where(email: auth.info.email).first
      if registered_developer.nil?
        developer = Developer.create!(
          email: auth.info.email,
          password: SecureRandom.base64(50),
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          subscribed_to_newsletter: true,
        )
        developer_provider = Identity.create!(
          provider:auth.provider,
          uid:auth.uid,
          developer_id: developer.id,
          token: auth.credentials.token,
          expires: auth.credentials.expires,
          expires_at: auth.credentials.expires_at,
          refresh_token: auth.credentials.refresh_token,
        )
        developer
      else
        Identity.create!(
          provider: auth.provider,
          uid: auth.uid,
          developer_id: registered_developer.id,
          token: auth.credentials.token,
          expires: auth.credentials.expires,
          expires_at: auth.credentials.expires_at,
          refresh_token: auth.credentials.refresh_token,
        )
        registered_developer
      end
    else
      identity.developer
    end
  end
end
