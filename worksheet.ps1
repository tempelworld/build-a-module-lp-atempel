# info besides readme


New-Item -Path . -Name "source" -ItemType "directory"

New-Item -Path .\source\ -Name "public" -ItemType "directory"
New-Item -Path .\source\ -Name "private" -ItemType "directory"
New-Item -Path .\source\ -Name "classes" -ItemType "directory"
New-Item -Path .\source\ -Name "enum" -ItemType "directory"

# get github repoe
$params = @{
    owner = "tempelworld"
    repo  = "apitest"
}

$repo = Get-GitHubRepository @params -Verbose
$repo
$repo.full_name

# create new github repo
$params = @{
    name = "apitest07"
}

$repo = New-GitHubRepository @params -Verbose
$repo
$repo.full_name

# rename a github repo
$params = @{
    owner = "tempelworld"
    repo = "apitest07"
    name = "apitestNew07"
}

$repo = Set-GitHubRepository @params -Verbose 
$repo
$repo.full_name

# delete a github repo

$params = @{
    owner = "tempelworld"
    repo  = "apitest03"
}

$repo = Remove-GitHubRepository @params -Verbose

# make manifest file (run once)
# New-ModuleManifest -Path .\source\WrapperApi.GitHub.psd1 -RootModule WrapperApi.GitHub.psm1

# build module
$params = @{
    version = '1.0.0'
    name = 'WrapperApi.GitHub'
}

.\build.ps1 @params

# git
git log --oneline

# 
git config --global user.email
git config --global user.name
git config --global user.name Alex



