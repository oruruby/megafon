class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone
      t.string :megafone_login
      t.string :megafone_password
      t.string :token
      t.string :name
      t.timestamps
    end
  end
end
