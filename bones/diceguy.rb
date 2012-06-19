require 'rubygems'
require 'isaac'

configure do |c|
  c.nick            = 'MrDiceguy'
#  c.password        = 'password'
  c.server          = 'irc.laddersoffice.com'
  c.port            = 6697
 c.ssl             = true
  c.verbose         = true
end

on :connect do
  join '#dice'
end

on :channel, /^hello_bot/ do
  msg channel, "Hello, #{nick}! Shall...we....play....a...game?"
end

on :channel, /^speak this: (.*)/ do
    msg channel,"#{match[0]}"
  end
  
  on :channel, /^mode: (.*)/ do
    #msg channel,"#{match[0]}"
	mode('#dice', match[0])
  end

on :channel, /^quote this: (.*)/ do
    msg channel, "Quote: '#{match[0]}' by #{nick}"
  end
 
on :channel, /^roll ([+-]?[0-9]*) ([+-]?[0-9]*)/ do
number_of_dice = match[0].to_i
number_of_sides = match[1].to_i
if number_of_dice > 20
msg channel, "too many die"
elsif number_of_sides > 999
msg channel, "too many sides on that dice!"
else
result = Array.new(number_of_dice)
result.map! {|x| rand(number_of_sides) + 1}
msg channel, "#{nick} rolled #{result.inspect}"
end
end

on :channel, /^!roll ([+-]?[0-9]*) ([+-]?[0-9]*)/ do
number_of_dice = match[0].to_i
number_of_sides = match[1].to_i
if number_of_dice > 20
msg channel, "too many die"
elsif number_of_sides > 999
msg channel, "too many sides on that dice!"
else
result = Array.new(number_of_dice)
result.map! {|x| rand(number_of_sides) + 1}
successes = result.find_all{|s| s > 7}.size
r = result.find_all{|s| s > 9}.size
msg channel, "#{nick} rolled #{result.inspect}   #{successes} Successes! #{r} Rerolls!"
reroll = result.find_all{|rr| rr > 9}.size
successcount = successes
while reroll > 0
newrolls = Array.new(reroll)
newrolls.map! {|x| rand(number_of_sides) + 1}
rrs = newrolls.find_all{|nr| nr > 7}.size
successcount += rrs
reroll -= newrolls.length
msg channel, "Your extra rolls: #{newrolls.inspect}  #{successcount}  Total Successes! #{reroll} Rerolls Left!"
if newrolls.find_all{|nnr| nnr > 9}.size > 0
addroll = newrolls.find_all{|nnr| nnr > 9}.size 
reroll += addroll
end
end
end
end

on :channel, /^exit/ do
Process.exit
end

# ruby documents/bones/diceguy.rb
