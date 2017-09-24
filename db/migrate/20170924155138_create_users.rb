class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :tokenid
      t.string :username
      t.string :password
      t.string :email
      t.string :phone_no

      t.timestamps null: false
    end
  end
end
