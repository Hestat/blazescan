# blazescan

Blazescan is a malware scanning tool, currently configured for Cpanel servers. there has been a dirth of updated scanners recently, and updating them would be the best longtermsolution, but until then, or if they do not get updated, we will have this.

# install

```git clone https://github.com/Hestat/blazescan.git```
```cd blazescan```
```./install.sh```
```blazescan```

# using

simply start with 

 ```blazescan```

The menu currently provides 2 scanning modes.

1. scan all cpanel doc roots, will enumerate and scan all doc roots on the server

2. scan a specific cpanel account, provide the cpanel user and it will scan for the one user

3. exit


# definitions

is built to use the following malware database

https://github.com/Hestat/lw-yara

runs using clamav as the scanning engine, will need to be installed to function properly.
