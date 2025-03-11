#!/bin/bash
#Script to clean the Buildroot environment

cd "$(dirname "$0")"

echo "Cleaning Buildroot with make distclean..."
make -C buildroot distclean

echo "Buildroot has been cleaned"
