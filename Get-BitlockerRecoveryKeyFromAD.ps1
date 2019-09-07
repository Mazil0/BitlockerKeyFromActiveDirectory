function Get-BitlockerRecoveryKeyFromAD {
    <#
    .SYNOPSIS
    Get Bitlocker recovery key by Computername or PasswordID

    .DESCRIPTION
    Get Bitlocker recovery key from Active Directory Computer object.
    Use property msFVE-RecoveryPassword
    
    .PARAMETER ComputerName
    Computer name
    
    .PARAMETER PasswordID
    Gets the BitLocker recovery password for this password ID (first 8 characters). 
    This parameter must be exactly 8 characters long and must contain only the characters 0 through 9 and A through F.
    
    .EXAMPLE
    Get-BitlockerRecoveryKeyFromAD -ComputerName "Comp1"
    Get-BitlockerRecoveryKeyFromAD -PasswordID "123B456C-78E0-90FB-9B58-17C7C2350B26"
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string]$ComputerName,
        [Parameter(Mandatory=$False)]
        [string]$PasswordID
    )
    
    #Find by PasswordID
    if ($PasswordID){
        
        $Results = Get-ADObject -Filter {objectClass -eq 'msFVE-RecoveryInformation'} -Properties msFVE-RecoveryPassword  | ? {$_.name -match "$passwordid"}
    }
    #Find by ComputerName
    else{

        $Results = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase (Get-ADComputer -Identity $ComputerName).DistinguishedName -Properties 'msFVE-RecoveryPassword'
    }
     Write-Host "`n===Found Bitlocker Key for: " -NoNewline 
     Write-Host  $ComputerName $PasswordID -ForegroundColor Yellow -NoNewline
     Write-Host "===`n"

    #Write results
    if($results){
       
        foreach ($Result in $Results){
            Write-Host "DateTime: "([DateTimeOffset] ($Result.name -split '{')[0]).DateTime
            Write-Host "RecoveryKey: " -NoNewline
            Write-Host $Result."msFVE-RecoveryPassword" -ForegroundColor Green
            Write-Host ("PasswordID: {"+($Result.name -split '{')[1])
            Write-Host "--------------------" 
        }#end foreach
    }#end if

    else {
        Write-Host "Recovery info for $ComputerName $PasswordID not found" -ForegroundColor Yellow
    }
  
}

