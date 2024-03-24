function Get-GitHubRepository() {
    <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER

    .EXAMPLE

    .INPUTS

    .OUTPUTS
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string]$owner,
       
        [Parameter(Mandatory)]
        [string]$repo
    )
   
    Begin {
        Write-Verbose -Message "[BEG]-[INFO] Begining $(myinvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $(myinvocation.mycommand)"

        $enpoint = "repos/$owner/$repo"

        $params = @{
            $endpoint = $enpoint
        }

        Write-Verbose -Message "[PRC]-[INFO] Calling Endpoint : [$($enpoint)]"
        Invoke-GitHub @params | ConvertFrom-Json
    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $(myinvocation.mycommand)"
    }
}