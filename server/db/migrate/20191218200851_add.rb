class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :connection_state, :string
    add_column :users, :next_disconnect_date, :datetime
  end
end
