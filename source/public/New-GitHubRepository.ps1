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