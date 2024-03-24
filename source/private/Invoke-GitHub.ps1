function Invoke-GitHub() {
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
       [string]$endpoint,

       [hashtable]$body,

       [ValidateSet("Get", "Post", "Delete", "Patch")]
       [string]$method = "Get",

       [switch]$returnRaw
    )
   
    Begin {
        Write-Verbose -Message "[BEG]-[INFO] Begining $($myinvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $($myinvocation.mycommand)"

        if ( -not ($Script:Connection)){
            throw "[PRC]-[WARN] Please connect to GitHub"
        }

        $url = "$($Script:Connection.baseUrl)/$($endpoint.TrimStart("/"))"
        Write-Verbose -Message "[PRC]-[INFO] Url : [$url]"
        
        $params = @{
            Method = $method
            Headers = $Script:Connection.Headers
            Uri = $url
        }

        if ($PSBoundParameters.ContainsKey('Body')){
            $params.Add("body", (ConvertTo-Json -InputObject $body -Depth 99))
        }

        $response = Invoke-WebRequest @params
        if ($returnRaw.IsPresent){
            return $response
        }
        else {
            return $response.Content
        }
    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($myinvocation.mycommand)"
    }
}