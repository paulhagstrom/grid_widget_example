class ChangePriceToDecimal < ActiveRecord::Migration
  # It was ridiculous that I left the price as a string with a $, won't sort right, too much trouble
  def self.up
    change_column :books, :price, :decimal
  end

  def self.down
    change_column :books, :price, :string
  end
end
