#!/bin/bash
PWD=$(pwd)

mkdir /usr/local/scan 2> /dev/null
cp -av $PWD/blazescan /usr/local/scan/
ln -s /usr/local/scan/blazescan /usr/local/bin/blazescan 2> /dev/null

echo -e "install complete"

