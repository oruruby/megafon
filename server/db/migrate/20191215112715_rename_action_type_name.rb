class RenameActionTypeName < ActiveRecord::Migration[6.0]
  def change
    rename_column :conference_actions, :name_cd, :status
  end
end
