#!/bin/bash

# create help function
helpFunction()
{
   echo ""
   echo "Usage: $0 [base|ostree|deploy|init]"
   echo -e "\tbase: Build the base image"
   echo -e "\tostree: Update the ostree image"
   echo -e "\tdeploy: Deploy the image to the target device"
   echo -e "\tinit: Initialize the ostree image"
   exit 1 # Exit script after printing help
}

# Check if the argument is passed
if [ -z "$1" ]; then
    echo "Please provide an argument"
    helpFunction
    exit 1
fi

# Check if the argument is cmd1 or cmd2
if [ "$1" == "base" ]; then
    debos recipes/base.yaml
elif [ "$1" == "ostree" ]; then
    debos recipes/update_ostree.yaml
elif [ "$1" == "deploy" ]; then
    debos recipes/deploy.yaml    
elif [ "$1" == "init" ]; then
    ./init_ostree.sh
else
    echo "Invalid argument"
    helpFunction
    exit 1
fi
