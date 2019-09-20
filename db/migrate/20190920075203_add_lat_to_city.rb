class AddLatToCity < ActiveRecord::Migration[6.0]
  require 'nokogiri'
	require 'open-uri'
   def change
     add_column :cities, :lat, :string
     add_column :cities, :lng, :string

       #import html data functionality
     data =Nokogiri::HTML(open('https://www.latlong.net/category/cities-102-15.html'))
     rows = data.css("table tr")
     rows.each do |row|
        City.create(name:row.css("td[1] a").text.split(', ')[0],
     	             state:row.css("td[1] a").text.split(', ')[1], 
     	             country:row.css("td[1] a").text.split(', ')[2],
     	             lat:row.css("td[2]").text,
                   lng:row.css("td[3]").text)
     end
   end
end
