class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :location
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
