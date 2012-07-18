class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount, precision: 20, scale: 2
      t.date :date
      t.string :type
      t.references :user
      t.timestamps
    end

    add_index :transactions, [:type, :user_id]
  end
end
