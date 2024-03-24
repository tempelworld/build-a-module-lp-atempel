function Connect-GitHub() {
    <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER

    .EXAMPLE

    .INPUTS

    .OUTPUTS
    #>

    Begin {
        Write-Verbose -Message "[BEG]-[INFO] Begining $(myinvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $(myinvocation.mycommand)"
    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $(myinvocation.mycommand)"
    }
}