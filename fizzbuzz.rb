x = 0;
beginning = Time.now
while x < 1000000 do
x +=1
end

puts "Time elapsed #{(Time.now - beginning)*1000} seconds"