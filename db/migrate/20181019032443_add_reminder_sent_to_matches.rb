class AddReminderSentToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :reminder_sent, :boolean, default: false
  end
end
