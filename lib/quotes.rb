# 
# Here is where you will write the class Quotes
# 
# For more information about classes I encourage you to review the following:
# 
# @see http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes
# @see Programming Ruby, Chapter 3
# 
# 
# For this exercise see if you can employ the following techniques:
# 
# Use class convenience methods: attr_reader; attr_writer; and attr_accessor.
# 
# Try using alias_method to reduce redundancy.
# 
# @see http://rubydoc.info/stdlib/core/1.9.2/Module#alias_method-instance_method
# 
class Quotes
  attr_reader :file
  attr_reader :quotes
  
  @@missing_quote = "Could not find a quote at this time"
  
  alias :all :quotes
  
  def initialize(params)
    @file = params[:file] if params[:file]
    if File.exist? @file
      @quotes = File.readlines(@file).collect {|line| line.chomp}
    end
    
    @quotes ||= []
  end
  
  def find(index)
    if @quotes.empty?
      @@missing_quote
    elsif index >= @quotes.size
      @quotes[rand(quotes.size-1)]
    else
      @quotes[index]
    end
  end
  
  def [](index)
    find(index)
  end
  
  def search(params = {})
    found_quotes = []
    
    params.each {|criteria, value|
      found_quotes << @quotes.find_all { |quote|
        quote.send(criteria.to_s + '?', value)
      }
    }
    
    if params.empty?
      @quotes
    else
      found_quotes.flatten
    end
  end
  
  def self.load(filename)
    Quotes.new(:file => filename)
  end
  
  def self.missing_quote=(quote)
    @@missing_quote = quote
  end
end