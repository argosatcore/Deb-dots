#!/bin/sh

# Get available windows:
windows=$(swaymsg -t get_tree | jq -r '
	recurse(.nodes[]?) |
		recurse(.floating_nodes[]?) |
		select(.type=="con"), select(.type=="floating_con") |
			(.id | tostring) + " " + .app_id + ": " + .name')

#Limit wofi's height with the number of opened windows:
length=$(echo "$windows" | wc -l)


# Select window with wofi
selected=$(echo "$windows" | wofi -d -i --lines "$length" -p "Switch to:" | awk '{print $1}')


# Tell sway to focus said window:
swaymsg [con_id="$selected"] focus
