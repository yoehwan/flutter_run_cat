#!/bin/bash


APP_NAME="flutter_run_cat"

RELEASE="https://github.com/yoehwan/flutter_run_cat/releases/download/v1.0.1/"

RELEASE_NAME="Run.Cat.v1.0.1.x64.linux.tar.xz"

OUTPUT="/usr/lib/$APP_NAME"


init()
{
echo "Start Install RunCat..."
}


killPS(){
	echo "kill Process...."
	if  pgrep -x "$APP_NAME" >/dev/null 
	then
		sudo pkill $APP_NAME
	fi
}


download()
{
	echo "Download New Release...."
	file=$RELEASE$RELEASE_NAME

	if [ ! -f "$RELEASE_NAME" ] ; then
	if [ -x "$(which wget)" ] ; then
		echo "download wget."
		wget $file
	elif [ -x "$(which curl)" ] ; then
		echo "download curl."
	else 
		echo "Could not find curl or wget, please install one."
	fi
	fi
}

unzip()
{
	echo "UnZip Download File...."
	if [ ! -f "$OUTPUT" ] ; then
		sudo mkdir -p $OUTPUT
	fi
	tar --overwrite -xvf $RELEASE_NAME -C "$OUTPUT"
	rm $RELEASE_NAME
}

addBin()
{
	echo "Add Binery...."
	cd /usr/bin && sudo ln -sf $OUTPUT/$APP_NAME $APP_NAME
}

completed()
{
	echo "
	Install Completed!
	Run commnd 'flutter_run_cat' in cmd.
	"
}

init

killPS

download

unzip

addBin

completed
