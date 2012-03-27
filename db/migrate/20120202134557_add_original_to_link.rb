class AddOriginalToLink < ActiveRecord::Migration
  def change
    add_column :links, :original, :string
  end
end
