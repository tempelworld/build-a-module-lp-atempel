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