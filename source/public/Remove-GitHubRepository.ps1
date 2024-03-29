function Remove-GitHubRepository() {
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
        Write-Verbose -Message "[BEG]-[INFO] Begining $($MyInvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $($MyInvocation.mycommand)"
       
        $method = "Delete"

        $endpoint = "repos/$Owner/$Repo"
        Write-Verbose -Message "[PRC]-[INFO] Endpoint : [$($endpoint)]"

        $params = @{
            endpoint = $endpoint
            method   = $method
        }
 
        Write-Verbose -Message "[PRC]-[INFO] Invoking Github : [$($method) - $($endpoint)]"
        Invoke-GitHub @params | ConvertFrom-Json

    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($MyInvocation.mycommand)"
    }
}