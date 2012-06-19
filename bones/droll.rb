#!/usr/bin/env ruby
require 'optparse'

=begin
  Droll.rb is a command line dice roller that doubles as a library that can be
  used to build other dice roller applications.  An example of this is the
  drollbot IRC dicebot, which is distributed with the droll program/library.

  Use the --help option for guidance on command line use.

  This software is is Copyright Chad Perrin, 2011, and  distributed under the
  terms of the Open Works License:

    # Open Works License

    This is version 0.8 of the Open Works License

    ## Terms

    Permission is hereby granted by the copyright holder(s), author(s), and
    contributor(s) of this work, to any person who obtains a copy of this work,
    in any form, to reproduce, modify, distribute, publish, sell, use, or
    otherwise deal in the licensed material without restriction, provided the
    following conditions are met:

    1. Redistributions, modified or unmodified, in whole or in part, must
       retain the above license notice, this list of conditions, and the
       following disclaimer.

    2. Redistributions, modified or unmodified, in whole or in part, must
       retain any applicable notices of attribution and copyright.

    No warranty or guarantee is implied by, or should be inferred from, this
    license or the act of distribution under the terms of this license.  This
    license does not grant permission to use the trade names, trademarks,
    service marks, product names, or other identifications used by the licensor
    except as required for reasonable and customary use in reproducing, and
    describing the origin or use of, the work.
=end


def process_die(dcode)
  d = Hash.new
  die_roll, d['sign'], d['mod'] = dcode.split(/([+-])/)
  d['num'], d['type'], die_vals = die_roll.split(/([A-Za-z])/)
  d['val'], d['thresh'] = die_vals.split(/\./)
  d['thresh'] ||= d['val'].sub(/^0/, '')

  d['num'] = 1 if d['num'] == ''
  d['sign'] ||= '+'
  d['mod'] ||= 0

  return d
end

def roll_dice(dbox)
  result_list = Array.new

  dbox.each do |raw_die_code|
    clean_die_code = raw_die_code.chomp
    running_totals = Array.new

    if clean_die_code.match(
      /^[1-9]*[0-9]*[A-Za-z][0-9]?[1-9]+[0-9]?(\.\d+)?[+-]?[0-9]*\s*(.*)$/
    )
      diecode = process_die(clean_die_code)

      if diecode['val'].match(/^[^0]/)
        if (diecode['val'].to_i < 2)
          return "bad die code: #{clean_die_code}"
        elsif diecode['thresh'].to_i == 1
          return "bad die code: #{clean_die_code}"
        end
      end

      if diecode['thresh'].to_i == 0
        return "bad die code: #{clean_die_code}"
      end

      if diecode['num'].to_i == 0
        return "bad die code: #{clean_die_code}"
      end

      diecode['num'].to_i.times do
        running_totals.push(
          roll_die diecode['val'], diecode['type'], diecode['thresh']
        )
        running_totals.flatten!
      end
    else
      return "bad die code: #{clean_die_code}"
    end

    result = clean_die_code + ': [' + running_totals.join(', ') + '] '
    result += "#{diecode['sign']} #{diecode['mod'].to_s} = "


    case diecode['sign']
    when '+'
      result += (
        running_totals.inject {|sum,n| sum ? sum+n : n } + diecode['mod'].to_i
      ).to_s
    when '-'
      result += (
        running_totals.inject {|sum,n| sum ? sum+n : n } - diecode['mod'].to_i
      ).to_s
    end

    result_list.push result
  end

  result_list
end

def get_discrete(dval)
  dval.match(/^0/) ? rand(dval.to_i + 1) : 1 + (rand dval.to_i)
end

def roll_die(die_value, die_type, die_threshhold)
  discrete_rolls = [get_discrete(die_value)]

  case die_type
  when 'x'
    c = 0
    while c < 1000              # arbitrary restriction to limit resource abuse
      # "Exploding" for the "x" die type should only kick in when a roll is
      # equal to the maximum value for that die.
      if discrete_rolls[-1] >= die_threshhold.to_i
        discrete_rolls.push get_discrete(die_value)
        c += 1
      else
        break
      end
    end
  end

  discrete_rolls.compact
end



if $0 == __FILE__
  Progname = 'droll'
  Version = '1.0rc2'

  help_text = {
    :help       => "Display this help text.\n\n",
    :version    => "Display version and license information.\n\n",
  }

  opts = OptionParser.new do |opts|
    # If optparse offers a way to create something like the banner that goes
    # *after* the option information in --help output, I don't know about it.
    # That's where some of the text in this banner should go -- most of it, in
    # fact.  Having all this stuff before the options makes the help output for
    # options less visible (and thus usable), but the die code explanation and
    # examples are kind of important.
    opts.banner = "\n    Usage: #{Progname} [options] [die_code]
      
    Die codes are constructed from five parts:
    
    1. Die Number
    
        The die number is an optional decimal number that determines how many
        of a die should be rolled.  For instance, if you wish to get the
        results of rolling two six-sided dice, the die number would be 2.
          
    2. Roll Type
        
        The roll type is a single-letter code used to specify how rolls should
        be treated by droll.

            d       Roll normally.

            x       On a single die result equal to the maximum value of the
                    die, roll another die of that type and add it to the total.
                      
    3. Die Value
                    
        The die value indicates the set of values the die can produce.  At
        present, two general types of die values are supported: a normal
        positive integer value (a whole number higher than zero), and such a
        value preceded by a zero.  If it is preceded by a zero, the die is
        treated as being marked with a range of numbers from zero to the value
        following the zero.  Otherwise, it is treated as being marked with a
        range of numbers from one to the value following the zero.
          
    4. Modifier Sign
        
        A plus or minus sign can be optionally used to indicate that a value
        should be added to, or subtracted from, the total when all dice
        indicated by the preceding components of the die code are \"rolled\"
        and their results added together.
          
    5. Modifier Value
        
        A numerical value is specified in conjunction with the modifier sign
        to indicate what should be added to or subtracted from the roll total.
          
    Examples:
    
        d10             Roll a single ten-sided die for values between 1 and 10.
        
        2d3             Roll two three-sided dice for values between 1 and 3.
                        Add the results together, for a total between 2 and 6.
        
        3x02            Roll three three-sided dice for values between 0 and 2.
                        For each 2 result, roll another three sided die for a
                        value between 0 and 2.  Repeat as necessary, then add
                        all values together.
                          
        3x02+3          Same as 3x02, but add 3 to the total.
        
    OPTIONS:\n\n"

    opts.on('--help', '-h', help_text[:help]) do
      $stderr.puts opts         # Some way to make some of the banner text
                                # optional without inventing a "minimal help"
                                # would be nice, but I haven't found one yet.

      exit!(0)
    end

    opts.on_tail('--version', help_text[:version]) do
      puts "#{Progname} #{Version}, Copyright 2011 Chad Perrin
      #{Progname} may be distributed under the terms of the Open Works License.
      See http://owl.apotheon.org for details."
      exit(0)
    end
  end.parse!

  puts roll_dice(ARGV)
end
