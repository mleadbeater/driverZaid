class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :kind
      t.string :title
      t.string :path

      t.timestamps
    end
  end
end
