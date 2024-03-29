Param(
    [string]$version = "1.0.0",
    [string]$name = "WrapperApi.GitHub"
)
   
$params = @{
    SourcePath                 = "$PSScriptRoot/source/WrapperApi.GitHub.psd1" 
    UnversionedOutputDirectory = $true
    Version                    = $Version
    Passthru                   = $true
    Verbose                    = $true
    OutputDirectory            = "$PSScriptRoot/build/WrapperApi.GitHub"
    SourceDirectories          = @("public", "private", "classes", "enum")
    PublicFilter               = "public\*.ps1"
}

Write-Host -Message "[PRC]-[INFO] Building Module [$name] - Version [$version]"
$result = Build-Module @params

try {
    Write-Host "[PRC]-[INFO] Loading module:[$($result.Path)]"
    Import-Module -Name $result.Path -ErrorAction stop -Force -Verbose    
}
catch {
    Throw "[PRC]-[ERRO] Failed to load module $_" 
}
finally {
    Write-Host "[PRC]-[INFO] Unloading module"
    Remove-Module -Name $result.Name -ErrorAction SilentlyContinue
}
