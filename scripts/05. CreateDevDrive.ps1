$ErrorActionPreference = "Stop"

# Define the path and drive letter for the Dev Drive
$devDrivePath = "C:\DevDrives\Default.vhdx"
$fixedDriveLetter = 'E'  # Specify the desired drive letter

# Create the directory for the VHDX file if it doesn't exist
New-Item -ItemType Directory -Path "C:\DevDrives" -Force

# Create the VHDX file
New-VHD -Path $devDrivePath -SizeBytes 50GB -Dynamic

# Mount the VHDX
Mount-VHD -Path $devDrivePath

# Get the disk for the newly mounted VHDX
$disk = Get-Disk | Where-Object { $_.PartitionStyle -eq 'RAW' }

# Initialize the disk
Initialize-Disk -Number $disk.Number

# Create a partition with a fixed drive letter
$partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -DriveLetter $fixedDriveLetter

# Format the partition using ReFS for Dev Drive optimization
Format-Volume -DriveLetter $fixedDriveLetter -DevDrive -FileSystem ReFS -NewFileSystemLabel "DevDrive"

Write-Output "Dev Drive created and initialized with drive letter: $fixedDriveLetter"