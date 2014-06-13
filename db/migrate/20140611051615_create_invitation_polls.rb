class CreateInvitationPolls < ActiveRecord::Migration
  def change
    create_table :invitation_polls do |t|
      t.integer :invitation_id
      t.integer :poll_id
      t.string  :token
      t.boolean :is_enabled
      t.timestamps
    end
  end
end
