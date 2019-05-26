# Trung Vo
echo Tesla Cam+Music USB drive maker tool

expectedDeviceName="USB DISK"

if [ -n "$1" ]; then diskId=$1
else 
	diskutil list
	read -p "Enter the $expectedDeviceName IDENTIFIER (ex: disk3): " diskId
	[ -z "$diskId" ] && echo "No diskId. Exit" && exit
fi
echo "diskId: '$diskId'"

info=$(diskutil info $diskId)

#protocol=$(printf "$info\n" | grep Protocol | cut -d ':' -f 2)
#echo "Protocol: $protocol"
#[[ "$protocol" == *"USB" ]] || (echo "Not USB drive. Exit" && exit)

deviceName=$(printf "$info\n" | grep 'Device / Media Name:' | cut -d ':' -f 2)
echo "Name: $deviceName"
[[ "$deviceName" == *"$expectedDeviceName" ]] || (echo "Not an $expectedDeviceName. Exit" && exit)

exit
diskutil eraseDisk JHFS+ %noformat% GPT $diskId || exit
diskutil list $diskId

diskutil splitPartition ${diskId}s1 FAT32 TESLA_CAM 512m FAT32 TESLA_MUSIC R
diskutil list $diskId

mkdir -p /Volumes/TESLA_CAM/TeslaCam