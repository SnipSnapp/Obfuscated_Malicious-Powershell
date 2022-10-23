https://www.safebreach.com/resources/blog/safebreach-labs-researchers-uncover-new-fully-undetectable-powershell-backdoor/


*** Do not launch the vbs unless you're comfortable with creating a schtask to call out to the address specified in Script1.ps1 ***
*** This was created for testing/learning purposes Do not use for malicious reasons ***

This is a modified version of the malware found in the above link. It won't call out to a C2. instead it does 127.0.0.1
Malware tasks:

  1. Launch VBS which creates the malicious powershell scripts Script1.ps1 and temp1.ps1 (Script1.ps1 hasn't been reversed yet so it's not here, I got the files mixed up).
  2. VBS script then registers the scheduled task Which launches the malicious powershell through:
        "wscript powershell.exe -Exec Bypass C:\Users\%User%\Microsoft\Update\Script1.ps1"
  3. When the Script1.ps1 is launched it calls out to the C2.
  4. temp1.ps1 goes ahead an executes the responses from the C2. 

Launch by running the vbs.  Wouldn't suggest it, but it won't call out to the C2 unless the .ps1 files are changed. This version isn't going to hurt things, and is NOT AN EXACT REPLICA of what the obfuscated malware is doing (especially in the vbs commands). The VBS script was modified so it doesn't rely on the XML docs inside of the docm file. I Might later include the XML thats packed and turns into these files at a later date, we'll see.
