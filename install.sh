#!/bin/bash
PWD=$(pwd)

mkdir /usr/local/scan
cp -av $PWD/blazescan /usr/local/scan/
ln -s /usr/local/scan/blazescan /usr/local/bin/blazescan

echo -e "install complete"

