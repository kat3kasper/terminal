class AddGetsMailToDevelopers < ActiveRecord::Migration[5.2]
  def change
    add_column :developers, :gets_mail, :boolean
  end
end
