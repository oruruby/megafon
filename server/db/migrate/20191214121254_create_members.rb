class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|

      t.integer :user_id
      t.integer :conference_id
      t.timestamps
    end
  end
end
