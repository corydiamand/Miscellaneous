# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

# Find the sum of all the multiples of 3 or 5 below 1000.


x=[]

1000.times do
	|i|
	if i % 5 == 0 or i % 3 == 0
		x << i
	end
end

sum = 0
x.each{ |a| sum += a}
puts sum
	