class Array                                                                                                                                                                                                    
  def take_while &blk                                                                                                                                                                                          
    inject [] do | a, e |                                                                                                                                                                                      
      if blk.(e, a)                                                                                                                                                                                            
        a << e                                                                                                                                                                                                 
      else                                                                                                                                                                                                     
        return a                                                                                                                                                                                               
      end                                                                                                                                                                                                      
    end                                                                                                                                                                                                        
  end                                                                                                                                                                                                          
end                                                                                                                                                                                                            
Prefix = %r{(\A\s*#\s)}                                                                                                                                                                                        
  module B extend self                                                                                                                                                                                         
    def make_lines wordz, length                                                                                                                                                                               
      result = []                                                                                                                                                                                              
      loop do                                                                                                                                                                                                  
        next_line = wordz.take_while{ |_,w| w.join(' ').size <= length }                                                                                                                                       
        return [result, std_variation(result)] if next_line.empty?                                                                                                                                             
        wordz = wordz.drop next_line.size                                                                                                                                                                      
        result << next_line.join(' ')                                                                                                                                                                          
      end                                                                                                                                                                                                      
    end                                                                                                                                                                                                        
                                                                                                                                                                                                               
    def std_variation lines                                                                                                                                                                                    
      ns   = lines.map(&:size)                                                                                                                                                                                 
      sum  = ns.reduce :+                                                                                                                                                                                      
      mean = sum.to_f / ns.size                                                                                                                                                                                
      ns.map{ | n | (mean - n) * ( mean - n ) }.reduce :+                                                                                                                                                      
    end                                                                                                                                                                                                        
                                                                                                                                                                                                               
    def blockset wordz, allowed_range                                                                                                                                                                          
      current_length = allowed_range.max                                                                                                                                                                       
      w = wordz.dup                                                                                                                                                                                            
      cache = [[], 99999999999]                                                                                                                                                                                
      loop do                                                                                                                                                                                                  
        # p cache: cache, n: current_length                                                                                                                                                                    
        lines, variation = make_lines w, current_length                                                                                                                                                        
        cache = [lines, variation] if variation < cache.last                                                                                                                                                   
        current_length -= 1                                                                                                                                                                                    
        return cache.first if current_length < allowed_range.min                                                                                                                                               
      end                                                                                                                                                                                                      
    end                                                                                                                                                                                                        
                                                                                                                                                                                                               
    def justify lines                                                                                                                                                                                          
      max = lines.map(&:size).max                                                                                                                                                                              
      lines.map do | line |                                                                                                                                                                                    
        length = line.size                                                                                                                                                                                     
        wordz  = line.split                                                                                                                                                                                    
        elements = [' '] * wordz.size                                                                                                                                                                          
        wordz.zip(((max - length).times.map{ '  ' } + elements).take( wordz.size.pred ).reverse).flatten.compact.join                                                                                          
      end         
    end
end

### Usecase as a vim filter:
require_relative './block.rb'                                                                                                                                                                                  
BEGIN {                                                                                                                                                                                                        
  lines = []                                                                                                                                                                                                   
}                                                                                                                                                                                                              
                                                                                                                                                                                                               
lines << $_.chomp                                                                                                                                                                                              
                                                                                                                                                                                                               
END {                                                                                                                                                                                                          
  prefix = lines.first.match( Prefix ).to_s                                                                                                                                                                    
  lines  = lines.map{ |line| line.sub Prefix, '' }                                                                                                                                                             
  words  = lines.map(&:split).flatten                                                                                                                                                                          
  max_size = ( lines.first.size.to_f * 1.20 ).to_i                                                                                                                                                             
  min_size = (max_size.to_f * 0.60 ).to_i                                                                                                                                                                      
                                                                                                                                                                                                               
  best_result = B.justify B.blockset words, min_size..max_size                                                                                                                                                 
  puts best_result.map{ | line | prefix + line }                                                                                                                                                               
}                            

    end                                                      
