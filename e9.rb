#A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#a2 + b2 = c2

#For example, 32 + 42 = 9 + 16 = 25 = 52.

#There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#Find the product abc.

a = 1
b = 2
c = 0

while a <= 1000
b = a + 1

while b <= 1000
c = (a**2) + (b**2) 
d = Math.sqrt(c)

	if d % 1 == 0 && (a + b + d) == 1000
	puts "a #{a} b #{b} c #{d}"
	puts a*b*d
	end
	b+=1
end	

a += 1
end
