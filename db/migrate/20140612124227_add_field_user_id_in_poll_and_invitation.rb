class AddFieldUserIdInPollAndInvitation < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :polls, :user_id, :integer
    add_column :invitations, :user_id, :integer
    add_column :users, :mark_as_deleted, :boolean, default: :false
  end
  
  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :username
    remove_column :polls, :user_id
    remove_column :invitations, :user_id
    remove_column :users, :mark_as_deleted
  end
end
