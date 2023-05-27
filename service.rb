require 'securerandom'

class UrlShortener
  attr_reader :url_map

  def initialize
    @url_map = {}
  end

  def shorten(url)
    short_code = generate_short_code
    url_map[short_code] = url
    short_code
  end

  def expand(short_code)
    url_map[short_code]
  end

  private

  def generate_short_code
    SecureRandom.urlsafe_base64(4)
  end
end

url_shortener = UrlShortener.new

loop do
  puts "What would you like to do?"
  puts "1. Shorten a URL"
  puts "2. Expand a short URL"
  puts "3. Exit"

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Enter a URL to shorten:"
    long_url = gets.chomp
    short_code = url_shortener.shorten(long_url)
    puts "Shortened URL: http://yourdomain.com/#{short_code}"
  when 2
    puts "Enter a short URL to expand:"
    short_url = gets.chomp
    short_code = short_url.split('/').last
    long_url = url_shortener.expand(short_code)
    if long_url
      puts "Expanded URL: #{long_url}"
    else
      puts "Invalid short URL"
    end
  when 3
    break
  else
    puts "Invalid choice"
  end

  puts "\n"
end
