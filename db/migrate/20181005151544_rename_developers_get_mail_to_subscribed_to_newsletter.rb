class RenameDevelopersGetMailToSubscribedToNewsletter < ActiveRecord::Migration[5.2]
  def change
    rename_column :developers, :gets_mail, :subscribed_to_newsletter
  end
end
