# coding: utf-8
class Car < ActiveRecord::Base
	set_inheritance_column :derive
	require 'open-uri'
		# require 'syck'
	# require 
	belongs_to :category
	include RoleModel
	 roles_attribute :roles_mask
	roles :diesel, :benzin, :autogas,:gasoline,:other,:essence
	def self.create_cate
		doc=Nokogiri::HTML(open('http://auto.vlan.be/en/second-hand-car/per-make-category'))
		doc.css('div.s_content_block_text ul li').each do |li|
			puts li.matches?('li')
			puts li.at_css('a').content
			c=Category.new
			c.name=li.at_css('a').content
			c.save
			doc2=Nokogiri::HTML(open("http://auto.vlan.be"+li.at_css('a')['href']))
			doc2.css('div.s_content_block_body .modellist ul li').each do |li2|
				next if li2.next.matches?('.sublevel')
			
				puts "----"+li2.at_css('a').content
				# puts "----"+li2.at_css('a')['href']
				# doc3=Nokogiri::HTML(open('http://auto.vlan.be'+li2.at_css('a')['href']))
				# doc3.css('table.zoek_resultaten > tr').each do |li3|
				# 	# puts li3.to_s
				# 	ob=li3.at_css("td[rowspan='2'] > a  strong")
				# 	unless ob.nil?
				# 		puts 'car title =>'+ob.content
				# 		# puts "00000"+ob.parent.parent.to_s.strip
				# 		# puts "11111"+ob.parent.parent.next.next.next.next.to_s.strip
				# 		# puts "22222"+ob.parent.parent.next.next.next.next.next.next.to_s.strip
				# 		puts 'car year =>'+ob.parent.parent.next.next.next.next.content.strip.split('/').reverse.join('-')
				# 		puts 'car price =>'+ob.parent.parent.next.next.next.next.next.next.content.gsub("€ ","").gsub(',','').strip
				# 		puts "car fuel =>"+	ob.parent.parent.parent.next.next.at_css('td').content.split(',').last.strip
				# 	end
				# end
					c2=Category.new
					c2.name=li2.at_css('a').content
				c2.parent=c
				c2.save
			end
		end
		
	end
	def self.testjob
		
	end
	def self.getdom(url)
		Nokogiri::HTML(open(url))
	end
	
	
end
