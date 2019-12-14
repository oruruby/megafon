class CreateConferenceActions < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_actions do |t|
      t.integer :name_cd
      t.integer :conference_id
      t.timestamps
    end
  end
end
