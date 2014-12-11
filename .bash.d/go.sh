#!/bin/bash
# Set up Go, but only on Macs
if [ `uname -s` == "Darwin" ]; then
	export GOPATH="$HOME/go"
fi
