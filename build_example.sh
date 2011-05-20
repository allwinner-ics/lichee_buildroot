#!/bin/bash

####################################################
#
# Show how to build buildroot automatically -- Benn
#
#####################################################

# Build all for sun4i platform

# Generate .config
make sun4i_defconfig

rm -rf output/build/lcd-test
rm -rf output/build/tp-test

# Start building
make


