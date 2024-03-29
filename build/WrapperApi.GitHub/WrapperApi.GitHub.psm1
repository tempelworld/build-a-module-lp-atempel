#Region '.\public\Connect-GitHub.ps1' -1

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
        
        # content type is needed on api for patch
        $contentType = "application/json"
        $method = "Get"

        $headers = @{
            "X-GitHub-ApiVersion" = $apiVersion
            "Authorization"       = "Bearer $($token | ConvertFrom-SecureString -AsPlainText)"
            "Content-Type"         = $contentType
        }

        $params = @{
            Uri     = $baseUrl
            Headers = $headers
            Method  = $method
        }

        $result = Invoke-RestMethod @params
        $currentUser = Invoke-RestMethod -Uri $result."current_user_url" -Headers $headers

        $Script:Connection = @{
            Headers    = $headers
            ApiVersion = $apiVersion
            BaseUrl    = $baseUrl
            Token      = $token
        }

        Write-Verbose "[PRC]-[INFO] [$($method) - $($baseUrl)]"
        Write-Verbose "[PRC]-[INFO] Logged in as: [$($currentUser.login)]"
    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($myinvocation.mycommand)"
    }
}
#EndRegion '.\public\Connect-GitHub.ps1' 68
#Region '.\public\Get-GitHubRepository.ps1' -1

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
        Write-Verbose -Message "[BEG]-[INFO] Begining $($myinvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $($myinvocation.mycommand)"

        $endpoint = "repos/$($owner)/$($repo)"
        $method = "Get"

        $params = @{
            endpoint = $endpoint
            method   = $method
        }

        Write-Verbose -Message "[PRC]-[INFO] Invoking Github : [$($method) - $($endpoint)]"
        Invoke-GitHub @params | ConvertFrom-Json
    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($myinvocation.mycommand)"
    }
}
#EndRegion '.\public\Get-GitHubRepository.ps1' 48
#Region '.\public\New-GitHubRepository.ps1' -1

function New-GitHubRepository() {
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
        [string] $Name,

        [string] $Description,

        [string] $Homepage,

        [boolean] $Private,

        [boolean] $HasIssues,

        [boolean] $HasProjects,

        [boolean] $HasWiki,

        [boolean] $HasDiscussions,

        [int] $TeamId,

        [boolean] $AutoInit,

        [string] $GitignoreTemplate,

        [string] $LicenseTemplate,

        [boolean] $AllowSquashMerge,

        [boolean] $AllowMergeCommit,

        [boolean] $AllowRebaseMerge,

        [boolean] $AllowAutoMerge,

        [boolean] $DeleteBranchOnMerge,

        [string] $SquashMergeCommitTitle,

        [ValidateSet("PR_BODY", "COMMIT_MESSAGES", "BLANK")]
        [string] $SquashMergeCommitMessage,

        [ValidateSet("PR_TITLE", "MERGE_MESSAGE")]
        [string] $MergeCommitTitle,

        [Validateset("PR_TITLE", "PR_BODY", "BLANK")]
        [string] $MergeCommitMessage,

        [boolean] $HasDownloads,

        [boolean] $IsTemplate
    )
   
    Begin {
        Write-Verbose -Message "[BEG]-[INFO] Begining $($MyInvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $($MyInvocation.mycommand)"

        $method = "Post"

        $endpoint = "user/repos"
        Write-Verbose -Message "[PRC]-[INFO] Endpoint : [$($endpoint)]"

        $body = @{}
        switch ($PSBoundParameters.Keys.GetEnumerator()) {
            "Name" { $Body["name"] = $PSBoundParameters["name"] }
            "Description" { $Body["description"] = $PSBoundParameters["description"] }
            "Homepage" { $Body["homepage"] = $PSBoundParameters["Homepage"] }
            "Private" { $Body["private"] = $PSBoundParameters["Private"] }
            "HasIssues" { $Body["has_issues"] = $PSBoundParameters["HasIssues"] }
            "HasProjects" { $Body["has_projects"] = $PSBoundParameters["HasProjects"] }
            "HasWiki" { $Body["has_wiki"] = $PSBoundParameters["HasWiki"] }
            "HasDiscussions" { $Body["has_discussions"] = $PSBoundParameters["HasDiscussions"] }
            "TeamId" { $Body["team_id"] = $PSBoundParameters["TeamId"] }
            "AutoInit" { $Body["auto_init"] = $PSBoundParameters["AutoInit"] }
            "GitignoreTemplate" { $Body["gitignore_template"] = $PSBoundParameters["GitignoreTemplate"] }
            "LicenseTemplate" { $Body["license_template"] = $PSBoundParameters["LicenseTemplate"] }
            "AllowSquashMerge" { $Body["allow_squash_merge"] = $PSBoundParameters["AllowSquashMerge"] }
            "AllowMergeCommit" { $Body["allow_merge_commit"] = $PSBoundParameters["AllowMergeCommit"] }
            "AllowRebaseMerge" { $Body["allow_rebase_merge"] = $PSBoundParameters["AllowRebaseMerge"] }
            "AllowAutoMerge" { $Body["allow_auto_merge"] = $PSBoundParameters["AllowAutoMerge"] }
            "DeleteBranchOnMerge" { $Body["delete_branch_on_merge"] = $PSBoundParameters["DeleteBranchOnMerge"] }
            "SquashMergeCommitTitle" { $Body["squash_merge_commit_title"] = $PSBoundParameters["SquashMergeCommitTitle"] }
            "SquashMergeCommitMessage" { $Body["squash_merge_commit_message"] = $PSBoundParameters["SquashMergeCommitMessage"] }
            "MergeCommitTitle" { $Body["merge_commit_title"] = $PSBoundParameters["MergeCommitTitle"] }
            "MergeCommitMessage" { $Body["merge_commit_message"] = $PSBoundParameters["MergeCommitMessage"] }
            "HasDownloads" { $Body["has_downloads"] = $PSBoundParameters["HasDownloads"] }
            "IsTemplate" { $Body["is_template"] = $PSBoundParameters["IsTemplate"] }
        }
        Write-Verbose -Message "[PRC]-[INFO] Body : [$($body)]"

        $params = @{
            endpoint = $endpoint
            method   = $method
            body     = $body
        }

        Write-Verbose -Message "[PRC]-[INFO] Invoking Github : [$($method) - $($endpoint)]"
        Invoke-GitHub @params | ConvertFrom-Json

    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($MyInvocation.mycommand)"
    }
}
#EndRegion '.\public\New-GitHubRepository.ps1' 124
#Region '.\public\Remove-GitHubRepository.ps1' -1

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
#EndRegion '.\public\Remove-GitHubRepository.ps1' 51
#Region '.\public\Set-GitHubRepository.ps1' -1

function Set-GitHubRepository() {
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
        [string] $Owner,
        [Parameter(Mandatory)]
        [string] $Repo,
        [string] $Name,
        [string] $Description,
        [string] $Homepage,
        [boolean] $Private,
        [string] $Visibility,
        [string] $SecurityAndAnalysis,
        [string] $DefaultBranch,
        [boolean] $AllowSquashMerge,
        [boolean] $AllowMergeCommit,
        [boolean] $AllowRebaseMerge,
        [boolean] $AllowAutoMerge,
        [boolean] $DeleteBranchOnMerge,
        [boolean] $AllowUpdateBranch,
        [boolean] $UseSquashPrTitleAsDefault,
        [string] $SquashMergeCommitTitle,
        [ValidateSet("PR_BODY", "COMMIT_MESSAGES", "BLANK")]
        [string] $SquashMergeCommitMessage,
        [ValidateSet("PR_TITLE", "MERGE_MESSAGE")]
        [string] $MergeCommitTitle,
        [Validateset("PR_TITLE", "PR_BODY", "BLANK")]
        [string] $MergeCommitMessage,
        [boolean] $Archived,
        [boolean] $AllowForking,
        [boolean] $WebCommitSignoffRequired 
    )
   
    Begin {
        Write-Verbose -Message "[BEG]-[INFO] Begining $($MyInvocation.mycommand)"
    }

    Process {
        Write-Verbose -Message "[PRC]-[INFO] Processing $($MyInvocation.mycommand)"

        $method = "Patch"

        $endpoint = "repos/$Owner/$Repo"
        Write-Verbose -Message "[PRC]-[INFO] Endpoint : [$($endpoint)]"

        $body = @{}
        switch ($PSBoundParameters.Keys.GetEnumerator()) {
            'Name' { $Body['name'] = $PSBoundParameters.Name }
            'Description' { $Body['description'] = $PSBoundParameters.Description }
            'Homepage' { $Body['homepage'] = $PSBoundParameters.Homepage }
            'Private' { $Body['private'] = $PSBoundParameters.Private }
            'Visibility' { $Body['visibility'] = $PSBoundParameters.Visibility }
            'SecurityAndAnalysis' { $Body['security_and_analysis'] = $PSBoundParameters.SecurityAndAnalysis | ConvertFrom-Json }
            'DefaultBranch' { $Body['default_branch'] = $PSBoundParameters.DefaultBranch }
            'AllowSquashMerge' { $Body['allow_squash_merge'] = $PSBoundParameters.AllowSquashMerge }
            'AllowMergeCommit' { $Body['allow_merge_commit'] = $PSBoundParameters.AllowMergeCommit }
            'AllowRebaseMerge' { $Body['allow_rebase_merge'] = $PSBoundParameters.AllowRebaseMerge }
            'AllowAutoMerge' { $Body['allow_auto_merge'] = $PSBoundParameters.AllowAutoMerge }
            'DeleteBranchOnMerge' { $Body['delete_branch_on_merge'] = $PSBoundParameters.DeleteBranchOnMerge }
            'AllowUpdateBranch' { $Body['allow_update_branch'] = $PSBoundParameters.AllowUpdateBranch }
            'SquashMergeCommitTitle' { $Body['squash_merge_commit_title'] = $PSBoundParameters.SquashMergeCommitTitle }
            'SquashMergeCommitMessage' { $Body['squash_merge_commit_message'] = $PSBoundParameters.SquashMergeCommitMessage }
            'MergeCommitTitle' { $Body['merge_commit_title'] = $PSBoundParameters.MergeCommitTitle }
            'MergeCommitMessage' { $Body['merge_commit_message'] = $PSBoundParameters.MergeCommitMessage }
            'Archived' { $Body['archived'] = $PSBoundParameters.Archived }
            'AllowForking' { $Body['allow_forking'] = $PSBoundParameters.AllowForking }
            'WebCommitSignoffRequired' { $Body['web_commit_signoff_required'] = $PSBoundParameters.WebCommitSignoffRequired }
        }

        Write-Verbose -Message "[PRC]-[INFO] Body : [$($body)]"

        $params = @{
            endpoint = $endpoint
            method   = $method
            body     = $body
        }
        Write-Verbose -Message "[PRC]-[INFO] Invoking Github : [$($method) - $($endpoint)]"
        Invoke-GitHub @params | ConvertFrom-Json

    }

    End {
        Write-Verbose -Message "[END]-[INFO] Ending $($MyInvocation.mycommand)"
    }
}
#EndRegion '.\public\Set-GitHubRepository.ps1' 100
#Region '.\private\Invoke-GitHub.ps1' -1

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

        if ( -not ($Script:Connection)) {
            throw "[PRC]-[WARN] Please connect to GitHub"
        }

        $url = "$($Script:Connection.baseUrl)/$($endpoint.TrimStart("/"))"
        Write-Verbose -Message "[PRC]-[INFO] Url : [$url]"
        
        $params = @{
            Method  = $method
            Headers = $Script:Connection.Headers
            Uri     = $url
        }

        if ($PSBoundParameters.ContainsKey('Body')) {
            $params.Add("body", (ConvertTo-Json -InputObject $body -Depth 99))
        }
        Write-Verbose -Message "[PRC]-[INFO] Calling API : [$method - $url]"
        $response = Invoke-WebRequest @params
        if ($returnRaw.IsPresent) {
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
#EndRegion '.\private\Invoke-GitHub.ps1' 66
