#require 'zliby'
require 'pr/zlib'


TAG_NAMES = {
     0 => "TAG_End",
     1 => "TAG_Byte",
     2 => "TAG_Short",
     3 => "TAG_Int",
     4 => "TAG_Long",
     5 => "TAG_Float",
     6 => "TAG_Double",
     7 => "TAG_Byte_Array",
     8 => "TAG_String",
     9 => "TAG_List",
    10 => "TAG_Compound",
    11 => "TAG_Int_Array"
  }


 
Zlib::GzipReader.open('bigtest.nbt') do |f|
     @content = f.read.bytes
    end

    content2 = []
     
    @content.each do |c|
    content2 << c
    end
    
    puts "Length in bytes: #{content2.length}"
    i = 0
 


=begin 
File.open('bigtestbytes.txt', 'w') do |f|
  f.puts 'test started at #{Time.now}'
  @content.each do |b|
        if TAG_NAMES[b] != nil
        f.puts"#{b} #{TAG_NAMES[b]}"
        else
        f.puts "#{b}   #{b.chr}"
        end
    end
  f.puts 'test ended at #{Time.now}'
end   
=end   

def getName(named, i , content2) 
#puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
				@@i = i
			end #if named
end

def Tag_end
end

def Tag_byte
end

def Tag_short
end

def Tag_int
end

def Tag_long

end

def Tag_float
end

def Tag_double
end

def Tag_byte_array
end

def Tag_string
end

def Tag_list
end

def Tag_compound
end

def Tag_int_array
end

named = true
@@i = 190
i = @@i

def run(content2,i,named)


    while (i < 300) #content2.length
	
    if content2[i] == 0    #TAG_End
        puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
        i +=1
		
    elsif content2[i] == 1    #TAG_Byte
        puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
        i +=1
		
    elsif content2[i] == 2    #TAG_Short
      #puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
		#payload
		payload = []
		payload << content2[i+1]
		payload << content2[i+2]
		i+=2
		puts "WORK IN PROGRESS #{payload.inspect.unpack('s>*')}"


    elsif content2[i] == 3    #TAG_Int
       #puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
		#payload handling
		payload = content2[i..i+3]
		puts " WORK IN PROGRESS #{payload.to_s.unpack('i>*')}"
		i+=4
		
		
		elsif content2[i] == 4    #TAG_Long
		#puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
		
		#begin payload handling
		payloadlength = 8
		content3 = []
        puts "Payload Length: #{payloadlength}"
        k = 0
        while k < payloadlength
        content3 << content2[i+k]
        k+=1
        end
		print "WORK IN PROGRESS #{content3.join.unpack('l*').inject(0){|sum,item| sum + item}}"
        i+= payloadlength
        puts ""
		
		
		elsif content2[i] == 5    #TAG_Float
        #puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
		#payload handling
		payload = content2[i..i+3]
		puts " WORK IN PROGRESS #{payload.to_s.unpack('g*')}"
		i+=4
		
		
    elsif content2[i] == 6    #TAG_Double
        puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
        i +=1
		
		
    elsif content2[i] == 7    #TAG_Byte_Array
        puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
        i +=1
		
		
		
    elsif content2[i] == 8    #TAG_String
				getName(named, i, content2)
                #puts name of tag via byte if not a list

=begin
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
=end
        #begin payload
        payloadlength = []
        payloadlength << content2[i]
        payloadlength << content2[i+1]
        payloadlength2 = payloadlength[0]+payloadlength[1]
        puts "Payload Length: #{payloadlength[0]+payloadlength[1]}"
        i+=2
        k = 0
        while k < payloadlength2
        print "#{content2[i+k].chr}"
        k+=1
        end
        i+= payloadlength2
        puts ""
		
		
        
    elsif content2[i] == 9    #TAG_List
        #puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
		#payload handling (type and # of items)
		payloadtype = content2[i]
		puts "payload type: #{payloadtype}"
		payloadlength = []
		payloadlength << content2[i+1..i+4]
		print payloadlength
		i+=5
		#if payloadtype != 10
		#named = false
		#end
		

    elsif content2[i] == 10    #TAG_Compound
       #puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
   
   
    elsif content2[i] == 11    #TAG_Int_Array
       #puts name of tag via byte if not a list
			if named == true
				puts "#{content2[i]} #{TAG_NAMES[content2[i]]}"
				#calculates length of name and then reads n bytes 
				namelength = []
				namelength << content2[i+1]
				namelength << content2[i+2]
				namelength2 = namelength[0]+namelength[1]
				puts "Name Length: #{namelength2}"
				i+=3
				puts "Name: "
				j = 0
			while j < namelength2
				print "#{content2[i+j].chr}"
				j+=1
			end
				i+= namelength2
				puts ""
			end #if named
		
    else
    puts "unknown #{content2[i].chr}"
    i +=1
    end    #if
	
	
end 	#while

end















run(content2,i,named)
 
=begin
file = File.open('r.0.0.mca')
    count = 0
    file.read(11000).each_byte do |b|
        if count == 8192 || count == 4095 || count % 1000 == 0 || count == (8192+1022)
        print "~~~~~~~~~~*#{count}*~~~~~~~~~~~~~~~~~~~~" 
        end
    print " #{b}"
      
    count +=1
    end
=end    


# big thanks to randomuser for all the help!!