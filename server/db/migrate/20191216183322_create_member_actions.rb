class CreateMemberActions < ActiveRecord::Migration[6.0]
  def change
    create_table :member_actions do |t|
      t.integer :name_cd
      t.integer :member_id
      t.timestamps
    end
  end
end
