$ErrorActionPreference = "Stop"

# Define variables
$vhdPath = "C:\HDVirtual\SQLServer.vhd"
$vhdSize = 30GB
$driveLetter = "D"

# Ensure the directory for the VHD file exists
New-Item -ItemType Directory -Path "C:\HDVirtual" -Force | Out-Null

# Create a fixed-size VHD
New-VHD -Path $vhdPath -SizeBytes $vhdSize -Fixed

# Mount the VHD
Mount-VHD -Path $vhdPath

# Get the mounted disk
$disk = Get-Disk | Where-Object { $_.PartitionStyle -eq 'RAW' }

# Initialize the disk with MBR
Initialize-Disk -Number $disk.Number -PartitionStyle MBR

# Create a partition on the disk and assign the drive letter
New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter -DriveLetter $driveLetter

# Format the partition as NTFS
Format-Volume -DriveLetter $driveLetter -FileSystem NTFS -NewFileSystemLabel "SQLServer"

# Optional: Set the partition as active (if needed)
Set-Partition -DiskNumber $disk.Number -PartitionNumber 1 -IsActive $true

# Display the result
Write-Output "VHD created and mounted as drive $driveLetter"