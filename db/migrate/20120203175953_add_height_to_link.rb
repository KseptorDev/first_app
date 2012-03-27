class AddHeightToLink < ActiveRecord::Migration
  def change
    add_column :links, :height, :integer
  end
end
