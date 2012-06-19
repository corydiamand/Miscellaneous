puts "enter your monthly income"
monthly_income = gets
puts "enter your cost of living"
rent = gets

monthly_income.to_i
rent.to_i

yearly_cost = 12 * rent.to_i
yearly_income = 12 * monthly_income.to_i
difference = (yearly_income.to_i - yearly_cost.to_i)

puts yearly_income.to_i		
puts yearly_cost.to_i
puts difference.to_i


# ruby documents/ruby_progs/finances.rb

# ruby finances.rb