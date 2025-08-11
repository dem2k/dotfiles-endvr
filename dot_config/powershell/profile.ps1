#Import-Module posh-git

## fzf settings. https://github.com/kelleyma49/PSFzf
#Set-PSFzfOption -EnableAliasFuzzyHistory -EnableAliasFuzzySetLocation
#Set-PSFzfOption -TabExpansion
#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PSReadlineOption -Colors @{ "InlinePrediction"="#49404F" }
Set-PsReadLineOption -PredictionViewStyle ListView -ErrorAction silentlycontinue
#Set-PSReadLineOption -HistorySavePath "C:\Users\x004123\.pwsh-history.txt"
Set-PsReadLineOption -EditMode Windows

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

## load all functions
dir ~/.config/powershell/my-*-fn.ps1 | foreach { . $_ }

