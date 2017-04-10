class AddUserReferenceToEntries < ActiveRecord::Migration[5.0]
  def change
    add_reference :entries, :user, foreign_key: true
  end
end
