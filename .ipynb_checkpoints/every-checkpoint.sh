#!/bin/bash

for vel in 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3
do
    awk 'BEGIN {OFS=","} {if ($1!="Loop") {print $1,$2,$3,$4,$5,$6}}' < ./RUN$vel/temp.txt > ./logsndumps/$vel.txt
    cp ./RUN$vel/dump.micelle ./logsndumps/$vel.dump
    mv ./movie$vel.mp4 ./movies/$vel.mp4
done
