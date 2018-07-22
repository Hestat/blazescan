# blazescan

Blazescan is a linux webserver malware scanning and incident response tool, with built in support for cPanel servers, but will run on any linux based server. If you are using consider reporting back unknown malicious files so we can add signatures for malware going forward.

# install

	git clone https://github.com/Hestat/blazescan.git
	cd blazescan
	./install.sh
	
During the install will check to see if Clamscan is present, if not please install ClamAV first.

https://www.clamav.net/downloads

Follow the install procedure best suited for your OS.

Additionally will ask if you want to install Maldet and WPCLI to take advantage of all supported features.

# using

simply start with 

 ```blazescan```


Blazescan is a malware scanning tool that uses clamav and custom malware databases

	If you run blazescan without any arguments it will present a simple scanning menu
	
  	  -a will scan all cpanel accounts
	
  	  -A will use Agressive mode to scan all cpanel accounts
     	  uses clamd to run multicore scans, can increase load
	
	  -u will scan the specified cpanel user
	
	  -l will show the results of the last scan
	
	  -t will display ctime of the hits in the last scan
	
	  -d scan a directory of your choosing
	
	  -w will run a scan on the directory of your choosing with wordpress checks included
	
	  -f will run search for all files in the directory given and record ctime of all files
	
	  -i provide a file to pull vital stats about the file
	
	  -m will email the list of hits from the last scan, set email in blazscand.conf Mailtoaddress
	
	  -U will check for updates, and allow you to perform any available updates
	
	  -R will allow you to report a malicious file back to add a signature
	     use this if you encounter new malicious code that is not detected
	
	  -h will display the help menu
	

By default the scanner will use the rules at https://github.com/Hestat/lw-yara

It will also use the maldet rules if installed http://www.rfxn.com/projects/linux-malware-detect/



# definitions


runs using clamav as the scanning engine, will need to be installed and at least version 98+ to function properly.

# Updates

Malware signatures update automatically. 

To update the scanner to the latest version either reclone and run the install script again, or if you have the repo still locally, run:

	git pull
	./install.sh

This will pull any changes from the git repo and apply them to your install.

## Articles

Writeups of the tool and its features:

https://laskowski-tech.com/2018/05/29/blazescan-linux-malware-scanning-utility/

https://laskowski-tech.com/2018/07/21/blazescan-v-1-3-updates/
