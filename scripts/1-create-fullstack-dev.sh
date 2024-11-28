#!/bin/bash

multipass launch \
    --cpus 4 \
    --memory 8G \
    --disk 50G \
    --name fullstack-dev \
    charm-dev