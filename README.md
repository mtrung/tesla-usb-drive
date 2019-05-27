# Tesla Cam+Music USB drive maker tool
For macOS only

## How to use
### Method 1 - Recommended
Double-click on the tesla-usb-drive.command and follow instructions.

### Method 2
Use the script with parameter.
This is good for automation/making multiple drives.

Syntax: `tesla-usb-drive.command USB_DISK_IDENTIFIER cam_partition_size`

Example: `tesla-usb-drive.command disk3 16g`

## Notes
- Requires that you have admin privilege
- Erases on data on your USB drive
- Works only on USB DISK to avoid mishap
- If you download the script as text file, you need to make this script executable using below command in Terminal: `chmod +x tesla-usb-drive.command`
