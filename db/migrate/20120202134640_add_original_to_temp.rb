class AddOriginalToTemp < ActiveRecord::Migration
  def change
    add_column :temps, :original, :string
  end
end
