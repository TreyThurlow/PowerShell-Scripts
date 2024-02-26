workflow Update_Computers {
    $computers = Get-Content -Path '.\Script Input\hostname.txt'
    $fileExtensions = "*.msi","*.msp","*.msu","*.exe"
    $sourcePath = "\\fileserver\updates"
    $destinationPath = "$env:SystemRoot\Temp"

    # Copy the files to each computer
    foreach -parallel ($computer in $computers) {
        InlineScript {
            foreach ($ext in $using:fileExtensions) {
                # Get the files with the specified extensions
                $files = Get-ChildItem -Path $using:sourcePath -Filter $ext

                # Copy the files to the destination path on the remote computer
                Copy-Item -Path $files.FullName -Destination "\\$using:computer\$using:destinationPath" -Force
            }
        }
    }

    # Install the updates on each computer
    foreach -parallel ($computer in $computers) {
        InlineScript {
            # Get the path of the folder containing the update files on the remote computer
            $updatePath = "\\$using:computer\$using:destinationPath"

            # Install the updates using the appropriate command for each file extension
            foreach ($ext in $using:fileExtensions) {
                switch ($ext) {
                    "*.msi" { Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $updatePath\*.msi /qn" -Wait }
                    "*.msp" { Start-Process -FilePath "msiexec.exe" -ArgumentList "/p $updatePath\*.msp /qn" -Wait }
                    "*.msu" { Start-Process -FilePath "wusa.exe" -ArgumentList "$updatePath\*.msu /quiet /norestart" -Wait }
                    "*.exe" { Start-Process -FilePath "$updatePath\*.exe" -ArgumentList "/quiet /norestart" -Wait }
                }
            }

            # Delete the update files from the remote computer
            Remove-Item -Path "$updatePath\*.*" -Force -Recurse
        }
    }
}
