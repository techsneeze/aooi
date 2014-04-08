Set oShell = CreateObject("Wscript.Shell")

Set WshSysEnv = oShell.Environment("PROCESS")
sProcArch = WshSysEnv("PROCESSOR_ARCHITECTURE")

Wscript.Echo ("Atomic Offline OS Installer for Windows. Version 0.1" & vbCrLf & "Author: Scott R. Shinn <scott@atomicrocketturtle.com>" & vbCrLf & vbCrLf & "This installer will re-image your server with CentOS 5." & vbCrLf & "DHCP is required to complete the installation.")

Wscript.Echo "Turtle power."

Select Case sProcArch
	Case "x86" 
		SourceURL1="http://www.atomicorp.com/installers/AOOI/i386/vmlinuz"
		SourceURL2="http://www.atomicorp.com/installers/AOOI/i386/initrd.img"
	Case "AMD64" 
		SourceURL1="http://www.atomicorp.com/installers/AOOI/x64_86/vmlinuz"
		SourceURL2="http://www.atomicorp.com/installers/AOOI/x64_86/initrd.img"
	Case "IA64" 
		SourceURL1="http://www.atomicorp.com/installers/AOOI/ia64/vmlinuz"
		SourceURL2="http://www.atomicorp.com/installers/AOOI/ia64/initrd.img"
	Case Else
		Wscript.Echo "Cannot determine processor architecture|processor architecture not supported"
		WScript.Quit
End Select

SourceURL3="http://www.atomicorp.com/installers/AOOI/win32/grubinst.exe"
SourceURL4="http://www.atomicorp.com/installers/AOOI/win32/grldr"
SourceURL5="http://www.atomicorp.com/installers/AOOI/win32/menu.lst"


TargetPath = "C:\vmlinuz"
SaveWebBinary SourceURL1,TargetPath

TargetPath = "C:\initrd.img"
SaveWebBinary SourceURL2,TargetPath

TargetPath = "C:\grubinst.exe"
SaveWebBinary SourceURL3,TargetPath

TargetPath = "C:\grldr"
SaveWebBinary SourceURL4,TargetPath

TargetPath = "C:\menu.lst"
SaveWebBinary SourceURL5,TargetPath

oShell.run "C:\grubinst.exe (hd0)"

Wscript.Echo ("Setup has successfully completed. Reboot your server to initiate the installation process" & vbCrLf & "The default root password will be set to: atomic555")

Function SaveWebBinary(strUrl, strFile) 'As Boolean
Const adTypeBinary = 1
Const adSaveCreateOverWrite = 2
Const ForWriting = 2
Dim web, varByteArray, strData, strBuffer, lngCounter, ado
    On Error Resume Next
    'Download the file with any available object
    Err.Clear
    Set web = Nothing
    Set web = CreateObject("WinHttp.WinHttpRequest.5.1")
    If web Is Nothing Then Set web = CreateObject("WinHttp.WinHttpRequest")
    If web Is Nothing Then Set web = CreateObject("MSXML2.ServerXMLHTTP")
    If web Is Nothing Then Set web = CreateObject("Microsoft.XMLHTTP")
    web.Open "GET", strURL, False
    web.Send
    If Err.Number <> 0 Then
        SaveWebBinary = False
        Set web = Nothing
        Exit Function
    End If
    If web.Status <> "200" Then
        SaveWebBinary = False
        Set web = Nothing
        Exit Function
    End If
    varByteArray = web.ResponseBody
    Set web = Nothing
    'Now save the file with any available method
    On Error Resume Next
    Set ado = Nothing
    Set ado = CreateObject("ADODB.Stream")
    If ado Is Nothing Then
        Set fs = CreateObject("Scripting.FileSystemObject")
        Set ts = fs.OpenTextFile(strFile, ForWriting, True)
        strData = ""
        strBuffer = ""
        For lngCounter = 0 to UBound(varByteArray)
            ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1, 1)))
        Next
        ts.Close
    Else
        ado.Type = adTypeBinary
        ado.Open
        ado.Write varByteArray
        ado.SaveToFile strFile, adSaveCreateOverWrite
        ado.Close
    End If
    SaveWebBinary = True
End Function
