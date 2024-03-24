# info besides readme


New-Item -Path . -Name "source" -ItemType "directory"

New-Item -Path .\source\ -Name "public" -ItemType "directory"
New-Item -Path .\source\ -Name "private" -ItemType "directory"
New-Item -Path .\source\ -Name "classes" -ItemType "directory"
New-Item -Path .\source\ -Name "enum" -ItemType "directory"

#
[securestring]$todaytoken = "github_pat_11ASYMF5A02FjiTaTH2J3m_D4SxraeWtPicI"  | ConvertTo-SecureString -AsPlainText 

[securestring]$todaytokenClassic = "ghp_87OvZOY3nvXnGgUKxOhzTiwN"  | ConvertTo-SecureString -AsPlainText 

$($todaytoken | ConvertFrom-SecureString -AsPlainText)
$($todaytokenClassic | ConvertFrom-SecureString -AsPlainText)

Connect-GitHub $todaytoken -Verbose
Connect-GitHub $todaytokenClassic -Verbose

$params = @{
    owner = "tempelworld"
    repo  = "apitest"
}

$repo = Get-GitHubRepository @params -Verbose
$repo
$repo.full_name



$params = @{
    name = "apitest07"
}

$repo = New-GitHubRepository @params -Verbose
$repo
$repo.full_name



:ToDo - content-type gives error

$params = @{
    owner = "tempelworld"
    repo = "apitest07"
    name = "apitestNew07"
}

$repo = Set-GitHubRepository @params -Verbose
$repo
$repo.full_name