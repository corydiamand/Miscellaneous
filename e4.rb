#A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

#Find the largest palindrome made from the product of two 3-digit numbers.


a = []

(100..999).each do |k|
	(100..999).each do |j|
		i = k * j
		rev = i.to_s.reverse
		i.to_s
 
		if i.to_s == rev
			a << i 
		end
	end
end

puts a.sort.last
