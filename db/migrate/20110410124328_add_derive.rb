class AddDerive < ActiveRecord::Migration
  def self.up
		change_table :cars do |t|
		  t.integer :derive
		end
  end

  def self.down
		change_table :cars do |t|
		end
  end
end