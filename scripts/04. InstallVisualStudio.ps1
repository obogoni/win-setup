# Install Visual
winget install --id Microsoft.VisualStudio.2022.Enterprise -h

# Wait for Visual Studio Installer to be ready
Start-Sleep -Seconds 10

# Now, run the Visual Studio Installer to add workloads
& "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe" `
  modify `
  --installPath "C:\Program Files\Microsoft Visual Studio\2022\Enterprise" `
  --config ..\config\VisualStudio\.vsconfig `
  --passive `
  --norestart `
  --allowUnsignedExtensions