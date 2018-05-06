class ChangeColumnPool < ActiveRecord::Migration[5.1]
  def change
    rename_column :groups, :pool, :buy_in 
  end
end
