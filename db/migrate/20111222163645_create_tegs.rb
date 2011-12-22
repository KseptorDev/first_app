class CreateTegs < ActiveRecord::Migration
  def change
    create_table :tegs do |t|
      t.string :teg

      t.timestamps
    end
  end
end
