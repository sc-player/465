#!/usr/bin/env ruby
require 'set'
STARTING_TRIES=10

tries=STARTING_TRIES	#set number of guesses
playingFair=false	#have we picked a word yet?
words=(`cat words`).split #get dictionary from file
letters=Set.new		#already guessed letters
pickedWord=""		#when we decide on a word it goes here
guess=String.new 	#player's guess
srand 			#seed random

print "Specify word size (5-20)\n"
size=[[20, $stdin.gets.to_i].min, 5].max  #enter size between 5 and 20
words.map!{|x| x if x.length==size}.compact!  #remove words form dictionary that arent size
matched=Array.new size, "_" 			#solution

while tries>=0 && (matched.include? "_") #while we have guesses and haven't guessed all the letters
	printf "Letters Guessed: %s\nRemaining Guesses: %i\nMatches: %s\n\nGuess a letter...\n", letters.to_a.join(" "), tries, matched.join
	guess = $stdin.gets.chop					#get guess
	until (guess =~ /^[a-z]$/) && !(letters.include? guess)		#keep getting guesses till format is correct
		print "Guess must be a-z and be unique\n"
		guess = $stdin.gets.chop
	end
	tries-=1							#reduce tries
	letters << guess						#add guess to guessed letters
	if !playingFair			#if we havent picked a word yet and there are words without the guess, remove them, 
		playingFair=true	#otherwise pick a random word
		words.each{|x| playingFair=false if !(x =~ /#{guess}/)}	
		words.map!{|x| x if !(x =~ /#{guess}/)}.compact! if !playingFair
		pickedWord=words[rand 0..words.size] if playingFair
	end
	if playingFair		#if we have picked a word find all matches and add to solution
		matchedIndexes=pickedWord.enum_for(:scan, /#{guess}/).map{Regexp.last_match.begin 0}
		matchedIndexes.each{|x| matched[x]=guess}
		tries+=1 if matchedIndexes.count>0 #increase tries if match
	end
end
#Print outcome message
if tries>=0
	printf "Congratulations, you won!\nTries left: %s\n", tries 
else
	printf "Game Over...\nWord: %s\nGuesses so far: %s\n", (pickedWord.empty?)?words[rand words.size]:pickedWord, matched.join
end
