# info besides readme


New-Item -Path . -Name "source" -ItemType "directory"

New-Item -Path .\source\ -Name "public" -ItemType "directory"
New-Item -Path .\source\ -Name "private" -ItemType "directory"
New-Item -Path .\source\ -Name "classes" -ItemType "directory"
New-Item -Path .\source\ -Name "enum" -ItemType "directory"

#
[securestring]$todaytoken = "github_pat_11ASYMF5A02FjiTaTH2J3m_D4SxraeWtPicI"  | ConvertTo-SecureString -AsPlainText 

$($todaytoken | ConvertFrom-SecureString -AsPlainText)

Connect-GitHub $todaytoken -Verbose

$params = @{
    owner = "tempelworld"
    repo  = "apitest"
}

Get-GitHubRepository @params