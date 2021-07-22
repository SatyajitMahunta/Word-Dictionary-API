class AddUsageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :usage, :integer
  end
end
