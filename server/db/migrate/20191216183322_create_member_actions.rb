class CreateMemberActions < ActiveRecord::Migration[6.0]
  def change
    create_table :member_actions do |t|
      t.integer :status
      t.integer :member_id
      t.timestamps
    end
    add_column :members, :aasm_state, :string
  end
end
