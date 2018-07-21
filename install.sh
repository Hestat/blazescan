#!/bin/bash
PWD=$(pwd)
##### Setting working environment #####

mkdir /usr/local/scan 2> /dev/null

#choose y/N to install
yesno(){ read -p "$question " choice;case "$choice" in y|Y|yes|Yes|YES ) decision=1;; n|N|no|No|NO ) decision=0;; * ) echo "invalid" && yesno; esac; }

##### formatting #####

#Creates variable for red color
red='\e[0;31m'
#Creates variable for bold red color
redbold='\e[1;31m'
#Creates variable for green color
green='\e[0;32m'
#Creates variable for yellow color
yellow='\e[1;33m'
#Creates variable for purple color
purple='\e[1;35m'
#Creates variable for no color
whi='\e[0m'
#blue
blue='\e[34m'


##### Install functions #####

wpcliinstall(){
	pushd /usr/local/src/
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	php wp-cli.phar --info
	chmod +x wp-cli.phar
	sudo mv wp-cli.phar /usr/local/bin/wp
	wp --info
	popd
}


maldetinstall(){
	pushd /usr/local/src/
	rm -vrf /usr/local/src/maldetect-*
	rm -vrf /usr/local/src/linux-malware-detect*
	wget http://www.rfxn.com/downloads/maldetect-current.tar.gz
	tar -zxvf maldetect-current.tar.gz
	cd maldetect-*
	sh ./install.sh
	maldet --update-ver
	#sed patch - commands added to address current problem with maldet overriding values in the conf file
	sed -i 's/quarantine_hits=\"1\"/quarantine_hits=\"0\"/' /usr/local/maldetect/conf.maldet
	sed -i 's/quarantine_clean=\"1\"/quarantine_clean=\"0\"/' /usr/local/maldetect/conf.maldet
	sed -i 's/email_alert=\"1\"/email_alert=\"0\"/' /usr/local/maldetect/conf.maldet
	sed -i 's/email_addr=\"you@domain.com\"/email_addr=\"\"/' /usr/local/maldetect/conf.maldet
	#end sed patch
	maldet --update
	if [ -e /usr/local/cpanel/3rdparty/bin/clamscan ]
	then
	ln -s /usr/local/cpanel/3rdparty/bin/clamscan /usr/bin/clamscan 
	ln -s /usr/local/cpanel/3rdparty/bin/freshclam /usr/bin/freshclam
	if [ ! -d /var/lib/clamav ]
	then mkdir /var/lib/clamav
	fi
	ln -s /usr/local/cpanel/3rdparty/share/clamav/main.cld /var/lib/clamav/main.cld
	ln -s /usr/local/cpanel/3rdparty/share/clamav/daily.cld /var/lib/clamav/daily.cld
	ln -s /usr/local/cpanel/3rdparty/share/clamav/bytecode.cld /var/lib/clamav/bytecode.cld 
	else
	echo -e "\n\e[31mClamAV does not appear to be installed through cPanel.\nThe ClamAV definitions will not be used.\e[39m\n"
	fi
	popd
}

###### Checking for required software and offering to install if needed #####

if [[ -x $(which whmapi1) ]]; then #cpanel try to link to clamAV
	ln -s /usr/local/cpanel/3rdparty/bin/clamscan /usr/bin/clamscan 2> /dev/null
	ln -s /usr/local/cpanel/3rdparty/bin/freshclam /usr/bin/freshclam 2> /dev/null
else #continue
	echo -e "$green Installing... $whi"
fi

if [[ -x $(which clamscan 2> /dev/null) ]]; then #clamav installed
	echo -e "$green\nFound ClamAV installed continuing\n$whi"
else
	echo -e "$redbold Please install ClamAV first, then run this script again\n $whi"
	exit 0
fi

if [[ -x $(which clamdscan 2> /dev/null) ]]; then #clamd installed
	cp -av $PWD/blazescand.conf /usr/local/scan/
	echo -e "MaxThreads $(expr $(nproc) / 2)" >> /usr/local/scan/blazescand.conf
	echo -e "$green\n Found Clamd installed continuing\n $whi"
else
	echo -e "$yellow\n Clamd not found, consider installing for multithread support\n"
fi


if [[ -x $(which maldet 2> /dev/null) ]]; then #maldet installed
	echo -e "$green Maldet installed continuing\n $whi"
else 
	echo -e "$yellow Would you like to install Maldet?\n $whi"
	yesno; if [ $decision = 1 ]; then
	echo -e "Installing maldet\n"
	maldetinstall
	else echo -e "continuing install\n"
	fi
fi

if [[ -x $(which wp 2> /dev/null) ]]; then #wpcli installed
	echo -e "$green Checking for wpcli updates $whi"
	wp cli update
	echo -e "$green WPCLI is installed continuing\n $whi"
else 
	echo -e "$yellow Would you like to install WPCLI?\n $whi"
	yesno; if [ $decision = 1 ];then
	echo -e "$green Installing WPCLI\n $whi"
	wpcliinstall
	else 
	echo -e "$green continuing install $whi"
	fi
fi

if [[ -x $(which zip 2> /dev/null) ]]; then #zip installed
	echo -e "$green zip installed continuing\n $whi"
else 
	echo -e "$yellow zip needs to be installed for -R reportings to function properly"
	echo -e " please run apt-get install, or yum install for zip package $whi"
	sleep 2
fi

##### moving scanner to proper dir to complete the install #####

if [[ -e /usr/local/scan/blazescand.conf ]];then
	cp -av $PWD/blazescan /usr/local/scan/
	ln -s /usr/local/scan/blazescan /usr/local/bin/blazescan 2> /dev/null
else
	cp -av $PWD/blazescand.conf /usr/local/scan/
	cp -av $PWD/blazescan /usr/local/scan/
	ln -s /usr/local/scan/blazescan /usr/local/bin/blazescan 2> /dev/null
fi

echo -e "$green\nInstall complete\nGood Hunting\n $whi"

