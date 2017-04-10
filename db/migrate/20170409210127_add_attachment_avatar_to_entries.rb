class AddAttachmentAvatarToEntries < ActiveRecord::Migration
  def self.up
    change_table :entries do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :entries, :avatar
  end
end
