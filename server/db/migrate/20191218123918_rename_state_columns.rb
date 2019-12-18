class RenameStateColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :loop_state, :string
    add_column :members, :mute_state, :string
    remove_column :members, :aasm_state
  end
end
