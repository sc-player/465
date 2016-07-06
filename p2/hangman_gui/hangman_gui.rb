#!/usr/bin/env ruby
require 'set'
require 'curses'
require 'io/console'
STARTING_TRIES=10

size=(ARGV[0]) ? [[20, ARGV[0].to_i].min, 5].max : 5
playingFair=false
$words=(`cat words`).split
$letters=Set.new
pickedWord=""
guess=String.new
$matched=Array.new size, "_"
$hangmanGraphic=(`cat hangman`).split
srand 
$shouldredrawscreen=false
$words.map!{|x| x if x.length==size}.compact!

def drawScreen 
	mid=Curses.cols/2
	div=Curses.lines-2
	Curses.clear
	Curses.setpos Curses.lines/2-7, mid-9
	Curses.addstr $hangmanGraphic.join("\n" + " " * (mid-9))
	Curses.setpos div, 0
	Curses.addstr "="*(Curses.cols)
	Curses.addstr "Guessed word: #{$matched.join}"
	Curses.setpos div+1, mid
	Curses.addstr "||Letters used: #{$letters.to_a.join " "}"
	$shouldredrawscreen=false
end

def addBodyPart num_tries
	return if num_tries>9
	if num_tries<=9
		Curses.setpos Curses.lines/2-6, Curses.cols/2+6
		Curses.addstr "\\|/"
		Curses.setpos Curses.lines/2-5, Curses.cols/2+7
		Curses.attron Curses::A_UNDERLINE if num_tries<9
		Curses.addch "|" 
		Curses.attroff Curses::A_UNDERLINE
	end
	if num_tries<=8
		Curses.setpos Curses.lines/2-5, Curses.cols/2+6
		Curses.addch "_"
		Curses.setpos Curses.lines/2-5, Curses.cols/2+8
		Curses.addch "_"
		Curses.setpos Curses.lines/2-4, Curses.cols/2+5
		Curses.addstr "|   |"
		Curses.setpos Curses.lines/2-3, Curses.cols/2+5
		Curses.addstr "|___|"
		
	end
	if num_tries<=7
		Curses.setpos Curses.lines/2-2, Curses.cols/2+7
		Curses.addstr "|"
		Curses.setpos Curses.lines/2-1, Curses.cols/2+7
		Curses.addstr "|"
		Curses.setpos Curses.lines/2, Curses.cols/2+7
		Curses.addstr "|"
	end
	if num_tries<=6
		Curses.setpos Curses.lines/2-1, Curses.cols/2+6
		Curses.addstr "\\"
	end
	if num_tries<=5
		Curses.setpos Curses.lines/2-1, Curses.cols/2+8
		Curses.addstr "/"
	end
	if num_tries<=4
		Curses.setpos Curses.lines/2+1, Curses.cols/2+6
		Curses.addstr "/"
	end
	if num_tries<=3
		Curses.setpos Curses.lines/2+1, Curses.cols/2+8	
		Curses.addstr "\\"
	end
	if num_tries<=2
		Curses.setpos Curses.lines/2-2, Curses.cols/2+7
		Curses.addstr "T"
	end
	if num_tries<=1
		Curses.setpos Curses.lines/2-4, Curses.cols/2+6
		Curses.addstr "x"
	end
	if num_tries<=0
		Curses.setpos Curses.lines/2-4, Curses.cols/2+8
		Curses.addstr "x"
	end
end

def appLoop
	playingfair=false
	tries=STARTING_TRIES
	while tries>=0 && ($matched.include? "_")
		Curses.refresh
		if $shouldredrawscreen
			r, c = $stdin.winsize
			Curses.resizeterm r,c
			drawScreen
		end
		guess=""
		until (/^[a-z]$/=~guess) && !($letters.include? guess)
			guess=Curses.getch
		end
		$letters << guess
		Curses.setpos Curses.lines-1, Curses.cols/2+15+$letters.size
		Curses.addstr guess
		tries-=1
		if !playingfair
			playingfair=true
			$words.each{|x| playingfair=false if !(x =~ /#{guess}/)}
			$words.map!{|x| x unless x =~ /#{guess}/}.compact! if !playingfair
			pickedWord=$words[rand 0..$words.size] if playingfair	
		end
		if playingfair
			matchedIndexes=pickedWord.enum_for(:scan, /#{guess}/).map{Regexp.last_match.begin 0}
			matchedIndexes.each{|x| $matched[x]=guess}
			if matchedIndexes.count>0
				tries+=1
				Curses.setpos Curses.lines-1, 14
				Curses.addstr $matched.join
			end
		end
		addBodyPart tries
	end
	(tries>=0) ? true : false
end	

def displayEndLoop victory
	frame=0
	message= (`cat #{(victory) ? "victory" : "gameover"}`).split("\n").each{|x| (x.length<Curses.cols) ? x<<" "*(Curses.cols-x.length) : x<<" "*10}
	top=Curses.lines/3
	bot=Curses.lines*2/3
	size=4
	input=""
	first=0
	last=0
	while !(input =~ /q/)	
		input=Curses.getch
		Curses.setpos top, 0
		Curses.attron Curses::A_UNDERLINE
		Curses.addstr "="*Curses.cols
		Curses.attroff Curses::A_UNDERLINE
		Curses.addstr " "*Curses.cols*(Curses.lines/3-3)
		Curses.attron Curses::A_UNDERLINE
		Curses.addstr " " * Curses.cols
		Curses.attroff Curses::A_UNDERLINE
		Curses.addstr "=" *Curses.cols
		curFirst=first%message[0].length
		curLast=last%message[0].length
		printStr=message.map{|x| (curLast>curFirst) ? x[curFirst..curLast] : x[curFirst..-1] << x[0..curLast]} 
		Curses.setpos top+1,0
		Curses.addstr printStr.map{|x| (x.length<Curses.cols) ? x.prepend(" "*(Curses.cols-curLast-curFirst-1)) : x}.join
		if frame%10000==0
			last+=1
			first+=1 if last-first>=Curses.cols
		end
		frame+=1
	end
end
Signal.trap("SIGWINCH") do
	$shouldredrawscreen=true
end

begin
	Curses.init_screen
	Curses.curs_set 0
	Curses.cbreak
	Curses.noecho
	Curses.nonl
	Curses.stdscr.nodelay=1
	drawScreen
	displayEndLoop appLoop
ensure
	Curses.close_screen
end



Curses.close_screen
