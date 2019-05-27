#!/bin/bash
# Author: Trung Vo
# Date: 5/26/19

expectedDeviceName="USB drive"
printf "\nTesla Cam+Music $expectedDeviceName maker tool\n\n"

isUsbDrive() {
    info=$(diskutil info $diskId | egrep 'Protocol|Whole|Media Name|Removable')

    local returnStr=$(printf "$info\n" | grep -m1 Protocol | cut -d ':' -f 2)
    echo "Protocol: $returnStr"
    if [[ "$returnStr" != *"USB" ]]; then echo "Not $expectedDeviceName. Exit"; exit; fi

    returnStr=$(printf "$info\n" | grep -m1 Whole | cut -d ':' -f 2)
    echo "Whole: $returnStr"
    if [[ "$returnStr" != *"Yes" ]]; then echo "Not whole $expectedDeviceName. Exit"; exit; fi

    echo "$info"
}


### param 1 validation

if [ -n "$1" ]; then diskId=$1
else 
    diskutil list
    read -p "Enter the $expectedDeviceName IDENTIFIER (ex: disk3): " diskId
    [ -z "$diskId" ] && ( echo "No input. Exit" && exit )
fi
echo "- $expectedDeviceName IDENTIFIER: $diskId"
isUsbDrive

### param 2 validation

if [ -n "$2" ]; then camPartSize=$2
else
    read -p "Enter Camera partition size (ex: 16g): " camPartSize
    [ -z "$camPartSize" ] && ( echo "No input. Exit" && exit )
fi
echo "- Camera partition size: $camPartSize"

### param 3 validation

if [ -n "$3" ]; then partitioningScheme=$3; else partitioningScheme=MBR; fi
echo "- Partitioning Scheme: $partitioningScheme"

### main
diskutil list $diskId
camPartName=T_CAM

if [ "$partitioningScheme" == "MBR" ] || [ "$partitioningScheme" == "GPT" ]; then
    diskutil partitionDisk ${diskId} $partitioningScheme FAT32 $camPartName $camPartSize FAT32 T_MUSIC R
else 
    echo "$partitioningScheme is not supported. Exit"; exit
fi

# diskutil list $diskId
sleep 1
mkdir -p /Volumes/$camPartName/TeslaCam
