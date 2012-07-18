class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
    	t.string :description
    	t.decimal :amount, precision: 20, scale: 2
    	t.references :user
      t.timestamps
    end
    add_index :expenses, :user_id
  end
end
