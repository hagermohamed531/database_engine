datatype() {
	select choice in "1-Numeric" "2-String(text)" "3-AlphaNumeric(varchar)"
	do
		case $REPLY in 
			1)coltype="int"
				return 0
				;;
			2)coltype="string"
				return 0
				;;
			3)coltype="mixed"
				return 0
				;;
			*) echo "please enter a valid choice !"
				#return 1
		esac
	done
}
