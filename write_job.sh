#!/bin/bash

if [ -e joblist.in ]
then
rm joblist.in
fi

touch joblist.in
var=$(find . -type d | wc -l)
echo $((var+2)) > joblist.in

find . -type d >> joblist.in
echo "./bulk/" >> joblist.in
echo "./dielectric/" >> joblist.in
echo "Everything has been written to the file successfully!"
