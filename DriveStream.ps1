New-Item -ItemType directory c:\temp
Invoke-WebRequest https://dl.google.com/drive-file-stream/GoogleDriveFSSetup.exe -OutFile C:\temp\GoogleDriveFSSetup.exe
& C:\temp\GoogleDriveFSSetup.exe --silent