# Tesla DashCam & Music USB drive maker tool
- Format USB drive into 2 partitions for DashCam and Music
- For macOS only

## Features
- Support 3 modes: cam only, music only, and both cam & music
- Create TeslaCam folder if applicable
- Fool-proof: validate all user inputs. Verify if the specified drive as USB drive.
- Support partitioning scheme MBR or GPT

## How to use
### Method 1 - Recommended
Double-click on the tesla-usb-drive.command and follow instructions.

### Method 2
Use the script with parameters. This is good for automation/making multiple drives.

Syntax: `tesla-usb-drive.command USB_DISK_IDENTIFIER Cam_Partition_Size Partitioning_Scheme`

- USB_DISK_IDENTIFIER: disk1
- Cam_Partition_Size: percentage (ex: 50%) or storage size value (ex: 16g)
   - To create cam partition only, use '100%'.
   - To create music partition only, use '0%' or '0'.
   - To create both, use 1%-99% or an in-betweeen storage size value
- Partitioning_Scheme: MBR or GPT. Optional. Default is MBR.

Example: `tesla-usb-drive.command disk3 16g MBR`

## Notes
- Requires that you have admin privilege
- Will wipe out all data on your USB drive
- It creates cam partition first using the above size param then music partition using remaining storage space.
- If you download the script as text file, you need to make this script executable using below command in Terminal: `chmod +x tesla-usb-drive.command`
- macOS diskutil will automatically add EFI partition with 200MB if you choose GPT partitioning scheme for >= 4GB drive.
