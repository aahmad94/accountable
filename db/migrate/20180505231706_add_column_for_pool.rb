class AddColumnForPool < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :pool, :integer
  end
end
