
a = 2**1000

a = a.to_s.split('')

a = a.map{|x| x.to_i}

sum = 0
a.each do |i|
sum += i
end

puts sum