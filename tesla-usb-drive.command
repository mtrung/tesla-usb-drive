# Author: Trung Vo
# Date: 5/26/19

printf "\nTesla Cam+Music USB drive maker tool"

expectedDeviceName="USB DISK"

### param 1 validation

if [ -n "$1" ]; then diskId=$1
else 
	diskutil list
	read -p "Enter the $expectedDeviceName IDENTIFIER (ex: disk3): " diskId
	[ -z "$diskId" ] && echo "No input. Exit" && exit
fi
echo "- $expectedDeviceName IDENTIFIER: $diskId"

# USB DISK verification
info=$(diskutil info $diskId)
deviceName=$(printf "$info\n" | grep 'Device / Media Name:' | cut -d ':' -f 2)
echo "Name: $deviceName"
[[ "$deviceName" == *"$expectedDeviceName" ]] || echo "Not an $expectedDeviceName. Exit" && exit

### param 2 validation

if [ -n "$2" ]; then camPartSize=$2
else
	read -p "Enter Camera partition size (ex: 16g): " camPartSize
	[ -z "$camPartSize" ] && echo "No input. Exit" && exit
fi
echo "- Camera partition size: $camPartSize"

### main

diskutil eraseDisk JHFS+ %noformat% GPT $diskId || exit
# diskutil list $diskId

diskutil splitPartition ${diskId}s1 FAT32 TESLA_CAM $camPartSize FAT32 TESLA_MUSIC R
diskutil list $diskId

mkdir -p /Volumes/TESLA_CAM/TeslaCam