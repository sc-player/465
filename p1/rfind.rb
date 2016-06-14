#!/usr/bin/env ruby
name= /#{ARGV[0]}/
strName=name.inspect[1..-1].chomp("/")
allfiles=(`find -name "*.rb" -o -name "*.erb" -o -name "*.js" -o -name "*.css" -o -name "*.html" -o -name "*.yml" -o -name "*.txt"`).split.sort
matchingfiles=Array.new
allfiles.each{|x| if x=~name then matchingfiles.push x end}
matchingfiles.sort
printf "Files with names that matches <%s>\n", strName
matchingfiles.each{|x| printf "  %s\n", x }
printedFirstString=false;
print "**************************************************\n"
printf "Files with content that matches <%s>\n", strName
allfiles.each{|x| if system("grep -iq #{strName} #{x}") then (if !printedFirstString then printedFirstString=true else print "--------------------------------------------------\n" end; printf "%s\n%s\n", x, (`grep -in #{strName} #{x}`).split("\n").map{|y| y.rjust(y.length+2)}.join("\n")) end}
