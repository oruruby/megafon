class CreateConferenceActions < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_actions do |t|
      t.intereg :name_cd
      t.timestamps
    end
  end
end
