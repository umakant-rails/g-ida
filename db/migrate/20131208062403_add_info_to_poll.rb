class AddInfoToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :info, :text
  end
end
