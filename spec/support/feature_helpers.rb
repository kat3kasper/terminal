module FeatureHelpers
  def sign_in user=nil, password="Password1"
    if user.is_a? Developer
      visit new_developer_session_path unless current_path == new_developer_session_path
    elsif user.is_a? Admin
      visit admin_session_path
    else
      visit recruiter_session_path unless current_path == recruiter_session_path
    end

    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    within 'form' do
      click_on 'Log in'
    end
  end
end

def google_mock_auth_hash
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    info: {
      email: 'mockuser@gmail.com',
      },
    },
    credentials: {
      token: 'abcdefg12345'
    }
  })
end

def linkedin_mock_auth_hash
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
    info: {
      email: 'mockuser@gmail.com',
      urls: {
        public_profile: 'http://linkedin.com/mockusername'
      },
    },
    credentials: {
      token: 'abcdefg12345'
    }
  })
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
