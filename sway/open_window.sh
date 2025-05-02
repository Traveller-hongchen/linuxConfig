#! /bin/bash

con_id=$(swaymsg -t get_tree | jq '.. | select(.window_properties?.class? == "'$1'")| .id ')
if [ "$con_id" != "" ]
then
	echo $con_id
	in_crath=$(swaymsg -t get_tree | jq '.. | select(.name? == "__i3_scratch") | .floating_nodes' | grep $1)
	if [ "$in_crath" != "" ]
	then
		echo '在隐藏区域'
		swaymsg "[con_id=$con_id] focus"
	else
		echo '正在显示'
		swaymsg "[con_id=$con_id] move scratchpad"
	fi
else
	echo '没有打开'
	$2
fi
