# Tesla Cam+Music USB drive maker tool
For macOS only

## Features
- Support partitioning scheme MBR or GPT
- Support 3 modes: cam only, music only, and both cam & music
- Fool-proof: validate all user inputs. Validate the specified drive.

## How to use
### Method 1 - Recommended
Double-click on the tesla-usb-drive.command and follow instructions.

### Method 2
Use the script with parameter.
This is good for automation/making multiple drives.

Syntax: `tesla-usb-drive.command USB_DISK_IDENTIFIER cam_partition_size Partitioning_Scheme`

- USB_DISK_IDENTIFIER: disk1
- cam_partition_size: number and storage unit. Ex: 16g.
   - To create cam partition only, use '100%'.
   - To create music partition only, use '0%'.
- Partitioning_Scheme: MBR or GPT. Optional. Default is MBR.

Example: `tesla-usb-drive.command disk3 16g MBR`

## Notes
- Create cam partition first using the above size param. Music partition will fill the remaining storage space.
- Requires that you have admin privilege
- Erases on data on your USB drive
- If you download the script as text file, you need to make this script executable using below command in Terminal: `chmod +x tesla-usb-drive.command`
