class AddSizeToLink < ActiveRecord::Migration
  def change
    add_column :links, :size, :string
  end
end
