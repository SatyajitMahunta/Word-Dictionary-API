class CreateApis < ActiveRecord::Migration[6.1]
  def change
    create_table :apis do |t|
      t.string :apikey
      t.integer :userid
      t.integer :count

      t.timestamps
    end
  end
end
