require 'http'
require 'open-uri'

puts "ENTER ANY WORD:"
user_input = gets.chomp

until user_input == "q"
  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/definitions?limit=5&includeRelated=false&useCanonical=false&includeTags=false&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")
  etymology = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/pronunciations?useCanonical=false&limit=5&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")
  tops = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/topExample?useCanonical=false&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")
  loud = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/audio?useCanonical=false&limit=50&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd")

  definitions = response.parse
  pronunciations = etymology.parse
  example = tops.parse["text"]
  spoken = loud.parse[0]["fileUrl"]

  puts user_input
  puts "~" * 30

  definitions.each do |definition|
      puts "- #{user_input} - #{definition["text"].to_s}"
      puts "~" * 30
  end

  puts "How do you say that???"
  puts "=" * 30

  pronunciations.each do |pronounce|
      puts "- Pronunciation - #{pronounce["raw"].to_s}"
      puts "=" * 30
  end

  puts "Can I get an example?"
  puts example

  puts "+" * 30

  puts "ENTER ANY WORD:"
  user_input = gets.chomp

  
  open spoken
  
  
  
end

puts "Thanks for participating!"