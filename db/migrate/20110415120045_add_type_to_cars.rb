class AddTypeToCars < ActiveRecord::Migration
  def self.up
		change_column :cars, :derive, :string
  end

  def self.down
		change_column :cars, :derive, :string
  end
end