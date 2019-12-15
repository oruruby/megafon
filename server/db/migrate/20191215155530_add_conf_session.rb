class AddConfSession < ActiveRecord::Migration[6.0]
  def change
    add_column :conferences, :conf_session, :string
  end
end
