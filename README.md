# blazescan

Blazescan is a malware scanning tool, currently configured for Cpanel servers. there has been a dearth of updated scanners recently, and updating them would be the best long term solution, but until then, or if they do not get updated, we will have this.

# install

	git clone https://github.com/Hestat/blazescan.git
	cd blazescan
	./install.sh
	

# using

simply start with 

 ```blazescan```


Blazescan is a malware scanning tool that uses clamav and custom malware databases

If you run blazescan without any arguments it will present a simple scanning menu

  -a will scan all cpanel accounts

  -u will scan the specified cpanel user

  -l will show the results of the last scan

  -t will display ctime of the hits in the last scan

  -d scan a directory of your choosing
  -h will display the help menu

By default the scanner will use the rules at https://github.com/Hestat/lw-yara

It will also use the maldet rules if installed http://www.rfxn.com/projects/linux-malware-detect/



# definitions


runs using clamav as the scanning engine, will need to be installed and at least version 98+ to function properly.
