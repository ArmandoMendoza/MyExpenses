class DropTableExpenses < ActiveRecord::Migration
  def up
  	drop_table :expenses
  end

  def down
  end
end
