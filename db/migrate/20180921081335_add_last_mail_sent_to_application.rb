class AddLastMailSentToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :last_mail_sent, :datetime, null: false,
               default: -> { 'CURRENT_TIMESTAMP' }
  end
end
