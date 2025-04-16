#!/bin/bash
awk '{u=$2; s=$3; t=$4} END {print u/($2+$3+$4)*100 "%"}' /proc/stat
