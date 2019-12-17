class AddCallSessionToMember < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :call_session, :string
  end
end
