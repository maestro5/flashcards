require 'open-uri'

current_date = Time.now
url = "http://1000mostcommonwords.com/1000-most-common-german-words/"
page = Nokogiri::HTML(open(url))

page.css('tr').each_with_index do |tr, index|
  next if index == 0
  Card.create(
    original_text:   tr.css('td')[1].text,
    translated_text: tr.css('td')[2].text,
    review_date_on:  current_date
  )
end

cards_count = Card.count
puts "#{cards_count} #{'card'.pluralize cards_count} was created from #{url}" unless cards_count.zero?
