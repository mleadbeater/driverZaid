class CreateWorkOrders < ActiveRecord::Migration
  def change
    create_table :work_orders do |t|
      t.string :category
      t.string :description
      t.datetime :due
      t.string :status

      t.timestamps
    end
  end
end
