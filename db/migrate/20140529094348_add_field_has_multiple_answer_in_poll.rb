class AddFieldHasMultipleAnswerInPoll < ActiveRecord::Migration
  def up
    add_column :polls, :has_multiple_answer, :boolean, :default => false
    add_column :responses, :poll_id, :integer
  end
  def down
    remove_column :polls, :has_multiple_answer
    add_column :responses, :poll_id
  end
end
