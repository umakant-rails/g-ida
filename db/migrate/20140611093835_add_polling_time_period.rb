class AddPollingTimePeriod < ActiveRecord::Migration
  def up
    add_column :polls, :survey_closed_at, :datetime
    add_column :invitations, :polling_allowed_for_all, :boolean, :default => false
  end
end
