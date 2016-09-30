#!/usr/bin/env zsh
# Get a random quote from a file that has a comma-separated list of quotes (quote, author, year, description)
# Created by Jasper Bogaerts 
# Inspired by rand-quote [~ Eduardo San Martin Morote aka Posva, see http://posva.github.io]
# 
# Thu Sep 29, 2016 
# Don't remove this header, thank you
# Usage: quote
COLOR="\x1B[37m" 
SEPARATOR='#'
#SOURE=<file_path>	# Please provide a file path here.
function quote() {
	quoteFile=$SOURCE
	if [[ $# -ne 0 ]] ; then
		quoteFile=$1
	else
		if [[ -z "$SOURCE" ]] ; then
			echo "Please provide a file in where quotes can be found!"
			return 1
		fi
	fi
	currentDate=`date +%H%d%m%y`
	numberOfQuotes=`wc -l < "$quoteFile"`
	index=$(($currentDate % $numberOfQuotes))
	quote=`tail -n $index $quoteFile | head -n 1 | head -n 1`

	local quoteItem
	quoteItem=()
	for item in ${(ps:$SEPARATOR:)quote}
	do	
		quoteItem+=$item
	done
	maxLength=0
	i=2
	while [ $i -lt 5 ]
	do
		currentItem=${quoteItem[$i]}
		if test $maxLength -lt ${#currentItem}
		then
			maxLength=${#currentItem}
		fi
		i=$(($i+1))
	done
	startPos=$((`tput cols` - $maxLength - 5))
	printf "%b" "$COLOR" 
	printf "%*s\n" $startPos "${quoteItem[1]}"
	printf "%b" "\x1B[0m"
	printf "%*s" `tput cols` "- ${quoteItem[2]}"
	printf "%*s" `tput cols` "  ${quoteItem[3]}"
	printf "%*s" `tput cols` "  ${quoteItem[4]}"
}
