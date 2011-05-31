#!/bin/bash

####################################################
#
# Show how to build buildroot automatically -- Benn
#
#####################################################

# Build all for sun4i platform

# Generate .config
if [ ! -e .config ]; then
	printf "\nUsing default config... ...!\n"
	make sun4i_defconfig
fi

rm -rf output/build/lcd-test
rm -rf output/build/tp-test

# Start building
make


