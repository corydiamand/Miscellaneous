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


File.open('bigtestbytes.rb', 'w') do |f|
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