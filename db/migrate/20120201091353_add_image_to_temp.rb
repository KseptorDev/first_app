class AddImageToTemp < ActiveRecord::Migration
  def change
    add_column :temps, :image, :string
  end
end
