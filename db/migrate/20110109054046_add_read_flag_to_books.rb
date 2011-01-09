class AddReadFlagToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :read, :boolean
  end

  def self.down
    remove_column :books, :read
  end
end
