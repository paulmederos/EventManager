# Dependencies
require "csv"

# Class Definition
class EventManager
  def initialize
    puts "EventManager Initialized."
    filename = "event_attendees.csv"
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
     @file.each do |line|
       zipcode = line[:zipcode]
       puts zipcode
     end
   end
   
   def clean_zipcode(original)
     if original.nil? 
       result = "00000"
     end
       
      if original.length < 5
        # Add zeros on the front
      end

    end
    
    def normalize_zip(zip)
      if zip.length < 5
        zeros_to_add = 5 - zip.length
        zeros_to_add.times { zip = "0" << zip }
      end
      
      zip unless zip.length != 5
    end

end

# Script
manager = EventManager.new
puts manager.normalize_zip("56")