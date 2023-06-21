# Get Bitlocker Key From Active Directory
Function Get Bitlcoker Reocvery Key From Active Directory  

Get Bitlocker recovery key by Computername or PasswordID
Use property msFVE-RecoveryPassword
    
    .PARAMETER ComputerName
    Computer name
    
    .PARAMETER PasswordID
    Gets the BitLocker recovery password for this password ID (first 8 characters). 
    This parameter must be exactly 8 characters long and must contain only the characters 0 through 9 and A through F.
    
    .EXAMPLE
    Get-BitlockerRecoveryKeyFromAD -ComputerName "Comp1"
    Get-BitlockerRecoveryKeyFromAD -PasswordID "123B456C-78E0-90FB-9B58-17C7C2350B26"
