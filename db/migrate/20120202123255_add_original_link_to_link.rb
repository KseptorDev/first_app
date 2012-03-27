class AddOriginalLinkToLink < ActiveRecord::Migration
  def change
    add_column :links, :originallink, :string
  end
end
