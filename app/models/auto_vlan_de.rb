# coding: utf-8
class AutoVlanDe < Car
	def self.execute
		Car.destroy_all('derive=1')
		doc=Nokogiri::HTML(open('http://auto.vlan.be/en/second-hand-car/per-make-category'))
		doc.css('div.s_content_block_text ul li').each do |li|

			doc2=Nokogiri::HTML(open("http://auto.vlan.be"+li.at_css('a')['href']))
			doc2.css('div.s_content_block_body .modellist ul li').each do |li2|
				next if li2.next.matches?('.sublevel')
				cate=Category.where('parent_id is not null').where("name like ?",'%'+li2.at_css('a').content+'%').first
				# puts "----"+li2.at_css('a').content
				# puts "----"+li2.at_css('a')['href']
				doc3=getCars(li2.at_css('a')['href'],cate)

				while(!(url=getNextPage(doc3)).nil?)
					puts url
					getCars(url,cate)	
				end
			end
		end
	end
	# handle_asynchronously :execute,:priority => 20

			def self.getNextPage(doc)
				if doc.at_css('table.zoek_resultaten ~ div')
				o=doc.at_css('table.zoek_resultaten ~ div').at_css('b').next 
				o.nil? ? o : o['href']	
				end
			end
			def self.getCars(url,cate)
				doc3=Nokogiri::HTML(open('http://auto.vlan.be'+url))
				doc3.css('table.zoek_resultaten > tr').each do |li3|
					# puts li3.to_s
					ob=li3.at_css("td[rowspan='2'] > a  strong")
					unless ob.nil?
						c=Car.new
						c.title=ob.content
						date=ob.parent.parent.next.next.next.next.content.strip.split('/')

							if date.size>1 && date.first.to_i < 10
								date[0] = "0" + date.first.to_i.to_s
							end
						puts date.join('-')
						c.year=Date.strptime(date.join('-'),(date.size>1 ? "%m-%Y" : "%Y"))
						c.price=ob.parent.parent.next.next.next.next.next.next.content.gsub("€ ","").gsub(',','').strip
						c.roles << ob.parent.parent.parent.next.next.at_css('td').content.split(',').last.strip.downcase.to_sym
						c.category=cate
						c.derive=1
						c.save
						puts "saved! "+c.title
					end
				end
				doc3
			end
end