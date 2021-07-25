class AddApiCntToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :api_cnt, :integer
  end
end
