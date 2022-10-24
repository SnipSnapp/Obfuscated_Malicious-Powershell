https://www.safebreach.com/resources/blog/safebreach-labs-researchers-uncover-new-fully-undetectable-powershell-backdoor/


# Do not launch the vbs unless you're comfortable with creating a schtask to call out to the address specified in Script1.ps1
# This was created for testing/learning purposes Do not use for malicious reasons
## What it does
This is a modified version of the malware found in the above link. It won't call out to a C2. instead it does 127.0.0.1
Malware tasks:

  1. Launch VBS which creates the malicious powershell scripts Script1.ps1 and temp1.ps1 (Script1.ps1 hasn't been reversed yet so it's not here, I got the files mixed up).
  2. VBS script then registers the scheduled task Which launches the malicious powershell through:
        "wscript powershell.exe -Exec Bypass C:\Users\%User%\Microsoft\Update\Script1.ps1"
  3. When the Script1.ps1 is launched it calls out to the C2.
  4. temp1.ps1 goes ahead an executes the responses from the C2. 

Launch by running the vbs.  Wouldn't suggest it, but it won't call out to the C2 unless the .ps1 files are changed. This version isn't going to hurt things, and is NOT AN EXACT REPLICA of what the obfuscated malware is doing (especially in the vbs commands). The VBS script was modified so it doesn't rely on the XML docs inside of the docm file. I Might later include the XML thats packed and turns into these files at a later date, we'll see.

## How it Does it
Read the de-obfuscated code, it's very heavily commented.  Start with the vbs, then Script1.ps1, then temp.ps1.

## Why does this get past AV/EDR 

These malicious scripts don't explicitely use the x64 encoded text to run something, instead they use obfuscated x64 and then decode it. The result is that most EDR/AV doesn't know how to interpret it because they don't use the x64 de-obfuscation which is inside of the script.
The scripts themselves are extremely straightforward. They state inside of them to call out to a C2 whose destination is unobfuscated, and to register a schtask on a windows machine. If an EDR doesn't react to the addition of a new schtask from a vba/vbs script then you need to look for a new EDR solution as this is how persistence is done within the malicious code.  Beyond that, The powershell is easily deobfuscated and sandboxing techniques should work on it.  If they don't then those sandboxing technologies need to be rethought as they don't try to get the value of a variable when a variable is changed, or when a new variable is instantiated. 
Instantiation of new variables is another way some EDR doesn't notice the malicious code. It's obfuscated by creating a new variable.  However, The same keywords for a lot of malicious powershell scripts and others can be found within these. The excuse of not inspecting new variables for content and finding out what's in them based on var type (all are within the strings) isn't an excuse here. 

Signature-based analytics will not be effective against this attack (like all malware really...) Behavior based can be utilized to stop this type of attack because what it's doing is certainly malicious. 
