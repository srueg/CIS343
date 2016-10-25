=begin
    Author: Simon Rüegg
    Assignment: Ruby Programming Project One
    Due Date: October 26, 2016 11:59 pm
=end

# Since Ruby automatically converts to a large integer in case of an overflow, 
# there is (practically) no limit to how big they can be.

print "Input hex value: "
input = gets

input.upcase!
input.gsub!(/\s+/, "")

if input =~ /^[0-9A-F]+$/
    output = input.to_i(16).to_s(10)
    puts "Base16: 0x#{input}, Base10: #{output}"
else
    puts "Invalid hex characters in input string: '#{input}'"
end
