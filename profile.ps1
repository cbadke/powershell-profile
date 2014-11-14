. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")

. $env:github_posh_git\profile.example.ps1

$dev = 'D:\git'

# If Posh-Git environment is defined, load it.
if (test-path env:posh_git) {
  . $env:posh_git
}

new-alias fsi 'C:\Program Files (x86)\Microsoft SDKs\F#\3.1\Framework\v4.0\Fsi.exe'
new-alias gitx 'gitextensions.exe'
new-alias open 'explorer.exe'
new-alias vi 'vim'

remove-item alias:\cd
new-alias cdd 'set-location'

new-alias which 'where.exe'
new-alias npe  nugetpackageexplorer

if ($host.Name -eq 'ConsoleHost') {
    if (Get-Module -ListAvailable PSReadline) {
        Import-Module PSReadline
        Set-PSReadlineKeyHandler -Key Tab -Function Complete
        Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
        Set-PSReadlineOption -HistorySearchCursorMovesToEnd
    }
}

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    $currPath = (get-location).path;
    $folders = $currPath.split([System.IO.Path]::DirectorySeparatorChar)

    $count = $folders.length

    if ($HOME -eq $currPath) {
        $curFolder = "~"
    }
    else {
        $curFolder = $folders[$folders.length - 1]
    }


    Write-VcsStatus

    Write-Host "[$curFolder]" -nonewline -ForegroundColor Magenta

    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}


function cd {
    param (
        [string]$Path,
        [switch]$PassThru,
        [switch]$UseTransaction
    )
    $x = Set-Location @PsBoundParameters

    if ($?) {
        Get-ChildItem
    }
    if ($PassThru) {
        return $x
    }
    return
}

function o {
  param (
    [string]$Path = '.'
  )
  explorer $Path
}
