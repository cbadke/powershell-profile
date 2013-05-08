$dev = 'D:\git'

# If Posh-Git environment is defined, load it.
if (test-path env:posh_git) {
    . $env:posh_git
}

new-alias fsi 'C:\Program Files (x86)\Microsoft SDKs\F#\3.0\Framework\v4.0\Fsi.exe'

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    $currPath = (get-location).path;
    $folders = $currPath.split([System.IO.Path]::DirectorySeparatorChar)

    $count = $folders.length

    if ($count -lt 2) {
        $curFolder = $folders[$folders.length - 1]
    } else {
        $curFolder = $folders[$folders.length - 2] + [System.IO.Path]::DirectorySeparatorChar + $folders[$folders.length - 1]
    }

    Write-Host "$curFolder" -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}