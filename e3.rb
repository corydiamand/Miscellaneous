


prime = 600851475143

(2..Math.sqrt(prime).to_i).each do |i|
	break if prime <= i
	prime /= i while (prime > i && prime % i == 0)
	end
	

	puts prime