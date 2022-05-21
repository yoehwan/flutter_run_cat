#!/usr/bin/bash


APP_NAME="flutter_run_cat"

AUTOSTART=$HOME/.config/autostart/$APP_NAME.desktop

LIB=/usr/lib/$APP_NAME

BIN=/usr/bin/$APP_NAME


remove(){
	file=$1
	if [ -f "$file" ]; then
		sudo rm -rf $file
	fi
}
psKill(){
	if pgrep -x "$APP_NAME" >/dev/null
	then
		sudo pkill $APP_NAME
	fi
}

psKill

remove $AUTOSTART
remove $LIB
remove $BIN


