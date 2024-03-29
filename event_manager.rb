# Dependencies
require "csv"

# Class Definition
class EventManager
  INVALID_ZIPCODE = "00000"
  
  def initialize(filename)
    puts "EventManager Initialized."
    @file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
  end
  
  def print_names
    @file.each do |line|
      puts line[2]
    end
  end
  
  def clean_number(original)
    cleaned_number = original.delete "-"
    cleaned_number = cleaned_number.delete " "
    cleaned_number = cleaned_number.delete "."
    cleaned_number = cleaned_number.delete " "
    cleaned_number = cleaned_number.delete "("
    cleaned_number = cleaned_number.delete ")"
    
    if cleaned_number.length == 11
      # remove first number (check if it's 1)
      if cleaned_number.start_with?('1')
        cleaned_number = cleaned_number[1..-1]
      end
    end
    
    cleaned_number = "0000000000" unless cleaned_number.length == 10
    cleaned_number
  end
  
  def print_numbers 
    @file.each do |line|
      number = clean_number(line[:homephone])        
      puts number
    end
  end
  
  def print_zipcodes
    amount = 0
     @file.each do |line|
       zipcode = clean_zipcode(line[:zipcode])
       amount += 1
       puts zipcode
     end
     # puts "Number of zip codes: " + amount.to_s
   end
   
  def clean_zipcode(original)
    original = EventManager::INVALID_ZIPCODE unless original.nil? 
    normalize_zip(original)
  end
    
  def normalize_zip(zip)
    if zip.length < 5
      (5 - zip.length).times { zip = "0" << zip }
    end
    
    zip unless zip.length != 5
  end
  
  def output_data(filename)
     output = CSV.open(filename, "w")
     @file.each do |line|
       line[:homephone] = clean_number(line[:homephone])
       output << line
     end
   end
end

# Script to run
manager = EventManager.new("event_attendees.csv")
puts manager.output_data("event_attendees_clean.csv")