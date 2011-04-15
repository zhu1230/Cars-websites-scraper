class CreateCarsTable < ActiveRecord::Migration
  def self.up
		create_table :cars, :force => true do |t|
		  t.string :title
		  t.integer :price
		  t.integer :title
		  t.date :year
		  t.integer :category_id
		  t.integer :roles_mask
		  t.timestamps
		end
		create_table :categories, :force => true do |t|

		        # Needed by acts_as_category
		        t.integer :parent_id, :children_count, :ancestors_count, :descendants_count
		        t.boolean :hidden

		        # Optional
		        t.string :name, :description
		        t.integer :position, :pictures_count

		      end
  end

  def self.down
		drop_table :cars
		 drop_table :categories
  end
end