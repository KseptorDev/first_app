class AddWidthToLink < ActiveRecord::Migration
  def change
    add_column :links, :width, :integer
  end
end
