original_words   = %w[movie cartoon garlic parsley]
translated_words = %w[фильм мультфильм чеснок петрушка]
review_dates     = %w[18.09.2017 19.09.2017 19.09.2017 20.09.17]

original_words.zip(translated_words, review_dates).each do |card|
  Card.create(
    original_text:   card[0],
    translated_text: card[1],
    review_date_on:  card[2]&.to_date
  )
end
