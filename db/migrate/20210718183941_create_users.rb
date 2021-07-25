class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.integer :plan_type, null: false
      t.integer :usage 
       
      t.timestamps
    end
  end
end
