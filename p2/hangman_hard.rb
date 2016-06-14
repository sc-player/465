#!/usr/bin/env ruby
#Extra credit implementation (hard mode).
require'set'
STARTING_TRIES=10
tries=STARTING_TRIES #Guesses
playingFair=false   #Have we been forced to play fair yet?
words=(`cat words`).split  #Get dictionary out of file "words"
letters=Set.new #Guessed letters so far
guess=String.new  #current guess
srand #seed random numbers

print "Specify word size (5-20)\n"  
size=[[20, $stdin.gets.to_i].min, 5].max #Size between 5 and 20
words.map!{|x| x if x.length==size}.compact!  #Toss words that dont match size
matched=Array.new size, "_"  #Create array to track our correct guesses
pickedWord=""         #word that we choose once forced to play fair

#While we still have lives and havent finished..
while tries>=0 && (matched.include? "_")
	printf "%s\nLetters Guessed: %s\nRemaining Guesses: %i\nMatches: %s\n\nGuess a letter...\n", words.size, letters.to_a.join(" "), tries, matched.join
	guess = $stdin.gets.chomp                               #Get guess
	until (guess =~ /^[a-z]$/) && !(letters.include? guess) #Continue getting guesses until you get the right format
		print "Guess must be a-z and be unique\n"
		guess = $stdin.gets.chomp
	end
	tries-=1 		#lose a guess
	letters << guess	#add guess to already guessed
	if !playingFair			#if we havent been forced to pick..
		playingFair=true	#See if guess matches
		words.each{|x| playingFair=false if !(x =~ /#{guess}/)}
		words.map!{|x| x if !(x =~ /#{guess}/)}.compact! if !playingFair
	end
	if playingFair		#otherwise count guess occurances in each string
		wordCounts=Array.new size, 0    #index
		words.each{|x| x.enum_for(:scan, /#{guess}/).map{Regexp.last_match.begin 0}.each {|x| wordCounts[x]+=1}}
		next if (wordCounts.reduce 0, :+)==0 #next iteration if none
		tries+=1		#otherwise add try for correct guess
		#if more than one word is possible, find index where the most occurances of guess are in the strings in dictionary. if not, reduce dictionary
		if words.size>1		
			maxIndex=wordCounts.index wordCounts.max 
			words.map!{|x| x if x[maxIndex] == guess}.compact! 
			counter=0
		#Update solution array with the max index guess if there is more than one word in the dictionary, otherwise, we have reduced the dictionary to one word, so we add all the letters in that word we already guessed to the solution array.
			if words.size>1 then matched[maxIndex]=guess else (0..size).each do |x| matched[x]=words[0][x] if letters.include? words[0][x] end end
		#if there is only 1 word left we add all occurances of the guess to the solution array.
		else wordCounts.each_index{|x| matched[x]=guess if words[0][x]==guess} end	
	end
end
#print final messages
if tries>=0
	printf "Congratulations, you won!\nTries left: %s\n", tries 
else
	printf "Game Over...\nWord: %s\nGuesses so far: %s\n", words[rand words.size], matched.join
end
