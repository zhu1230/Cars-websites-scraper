class Changetitle < ActiveRecord::Migration
  def self.up
		change_column :cars, :title, :string
  end

  def self.down
		change_column :cars, :title, :string
  end
end