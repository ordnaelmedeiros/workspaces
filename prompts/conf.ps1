Set-Alias ll dir
function Prompt {
    if ("$(Get-Location)" -eq "$HOME") {
        $folder = "~"
    } else {
        $folder = Split-Path (Get-Location) -Leaf
    }
    $branchName = git branch --show-current
    $space = $folder.length + 4
    if ($branchName) {
        $space += $branchName.length + 4
    }

    $libs = $env:ASDF_CURRENT_PLUGINS -split "\|"
    if ($libs) {
        $space += 1
        $space += $env:ASDF_CURRENT_PLUGINS.length +1
    }
    $lines = ""
    for ($i=1; $i -le $host.UI.RawUI.WindowSize.Width-$space; $i++) {
        $lines += "─"
    }
    Write-Host "┌(" -ForegroundColor DarkGray -NoNewline
    Write-Host -ForegroundColor Cyan "$folder" -NoNewline
    if ($branchName) {
        Write-Host " on " -ForegroundColor DarkYellow -NoNewline
        Write-Host "$branchName" -ForegroundColor DarkGreen -NoNewline
    }
    Write-Host ")" -ForegroundColor DarkGray -NoNewline
    Write-Host "$lines" -ForegroundColor DarkGray -NoNewline
    if ($libs) {
        Write-Host "(" -ForegroundColor DarkGray -NoNewline
        $first = 1
        ForEach ($l in $libs) {
            if ($first -eq 1) {
                $first = 0
            } else {
                Write-Host "|" -ForegroundColor DarkGray -NoNewline
            }
            $lib = $l -split " "
            Write-Host "$($lib[0])" -ForegroundColor DarkYellow -NoNewline
            Write-Host " $($lib[1])" -ForegroundColor DarkGreen -NoNewline
        }
        Write-Host ")" -ForegroundColor DarkGray -NoNewline
    }
    Write-Host "┐" -ForegroundColor DarkGray
    Write-Host "└" -ForegroundColor DarkGray  -NoNewline
    " "
}
