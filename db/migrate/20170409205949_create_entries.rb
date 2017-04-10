class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :caption
      t.string :location

      t.timestamps
    end
  end
end
