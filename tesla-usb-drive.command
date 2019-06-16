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
if [ "$partitioningScheme" == "GPT" ]; then
    echo "macOS diskutil will automatically add EFI partition with 200MB for GPT partitioning scheme for >= 4GB drive"
fi


### main
diskutil list $diskId
camPartName=T_CAM

if [ "$partitioningScheme" == "MBR" ] || [ "$partitioningScheme" == "GPT" ]; then
    if [ "$camPartSize" == "100%" ]; then 
        diskutil partitionDisk ${diskId} $partitioningScheme FAT32 $camPartName $camPartSize
        sleep 1
        mkdir -p /Volumes/$camPartName/TeslaCam
        ls /Volumes/$camPartName/TeslaCam
    elif [ "$camPartSize" == "0%" ]; then 
        diskutil partitionDisk ${diskId} $partitioningScheme FAT32 T_MUSIC 100%
    else
        diskutil partitionDisk ${diskId} $partitioningScheme FAT32 $camPartName $camPartSize FAT32 T_MUSIC R
        sleep 1
        mkdir -p /Volumes/$camPartName/TeslaCam
        ls /Volumes/$camPartName/TeslaCam        
    fi
else 
    echo "$partitioningScheme is not supported. Exit"; exit
fi

# diskutil list $diskId

read -p "Do you want to unmount ${diskId} now? " answer
if [ "$answer" == "y" ]; then
    diskutil unmount /dev/${diskId}s1
    diskutil unmount /dev/${diskId}s2
fi
