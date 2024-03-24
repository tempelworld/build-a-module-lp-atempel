function Connect-GitHub() {
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
        [securestring]$token,

        [string]$baseUrl = "https://api.github.com",

        [ValidateSet("2022-11-28")]
        [string]$apiVersion = "2022-11-28"
    )
   
    Begin {
        Write-Verbose -Message "[BEG]-[INFO] Begining $($myinvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $($myinvocation.mycommand)"

        $headers = @{
            "X-GitHub-ApiVersion" = $apiVersion
            "Authorization"       = "Bearer $($token | ConvertFrom-SecureString -AsPlainText)"
        }

        $params = @{
            Uri     = $baseUrl
            Headers = $headers
            Method  = "Get"
        }

        $result = Invoke-RestMethod @params
        $currentUser = Invoke-RestMethod -Uri $result."current_user_url" -Headers $headers

        $Script:Connection = @{
            Headers    = $headers
            ApiVersion = $apiVersion
            BaseUrl    = $baseUrl
            Token      = $token
        }

        Write-Verbose "[PRC]-[INFO] Logged in as: [$($currentUser.login)]"
    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($myinvocation.mycommand)"
    }
}