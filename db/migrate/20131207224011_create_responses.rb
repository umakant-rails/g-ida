class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :answer, index: true
      t.string :userid

      t.timestamps
    end
  end
end
