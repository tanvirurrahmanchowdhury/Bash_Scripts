#!/bin/bash

VAR=12.3
JOB=4

echo "$VAR - $JOB" | bc
echo "$VAR + $JOB" | bc
echo "$VAR * $JOB" | bc
echo "scale=5;sqrt($VAR)" | bc
