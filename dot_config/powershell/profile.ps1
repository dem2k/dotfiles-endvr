#Import-Module posh-git

Remove-Item alias:curl -ErrorAction SilentlyContinue
Remove-Item alias:wget -ErrorAction SilentlyContinue
 
# meine aliases
Set-Alias l   get-childitem
function  ll {get-childitem -Force}

# meine functionen
# function lf { c:\scoop\apps\lf\current\lf.exe -print-last-dir|cd }
# function glog { git.exe log --graph --pretty=format:"%C(auto)%h%<(3)%d %s %C(bold blue)(%cr, %an)%Creset" --abbrev-commit --all }


# fzf settings
# https://github.com/kelleyma49/PSFzf
# Set-PSFzfOption -EnableAliasFuzzyHistory -EnableAliasFuzzySetLocation
#Set-PSFzfOption -TabExpansion
#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PSReadlineOption -Colors @{ "InlinePrediction"="#49404F" }
Set-PsReadLineOption -PredictionViewStyle ListView -ErrorAction silentlycontinue
# Set-PSReadLineOption -HistorySavePath "C:\Users\x004123\.pwsh-history.txt"
Set-PsReadLineOption -EditMode Windows



function prompt {
    [CmdletBinding()]
    param ()
    
    $IsAdmin = if ($IsWindows) {
        ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    # Set-PSReadLineOption -PromptText @("> ","# ")[[Security.Principal.WindowsIdentity]::GetCurrent().Groups.Value.Contains("S-1-5-32-544")]
    }
    elseif ($IsLinux) { 0 -eq (id -u) }
    elseif ($IsMacOS) { 0 -eq (id -u) }

    $Identity = if ([System.Environment]::UserDomainName -ne [System.Environment]::MachineName) {
        $Identity = "{0}\" -f [System.Environment]::UserDomainName
    }
    $Identity += "{0}@{1}" -f [System.Environment]::UserName, [System.Environment]::MachineName

    Set-PSReadLineOption -PromptText @("> ","# ")[$IsAdmin]
    Set-PSReadLineOption -ContinuationPrompt (">> {0}" -f $(" " * ($nestedPromptLevel + 1)))
    $host.ui.RawUI.WindowTitle = $Identity
    $PSReadLineOption = Get-PSReadLineOption

    $Path       = "{0}{1}" -f $PSReadLineOption.KeywordColor,
                                $ExecutionContext.SessionState.Path.CurrentLocation.ProviderPath.Replace($Home, "~")
    $Timestamp  = "`e[2m{0}{1}`e[0m" -f $PSReadLineOption.CommandColor,
                                [datetime]::Now.ToString('dd.MM.yyyy, HH:mm:ss')
    $HostInfo   = "{0}{1}" -f $PSReadLineOption.StringColor,
                                $Identity
    $PSVersion  = "{0}PS{1}{2}.{3}" -f $PSReadLineOption.TypeColor,
                                        $PSReadLineOption.EmphasisColor,
                                        $PSVersionTable.PSVersion.Major,
                                        $PSVersionTable.PSVersion.Minor
    $Prompt     = "{0}{1}" -f $PSReadLineOption.TypeColor,
                                [string]$PSReadLineOption.PromptText

    # $GitStatus = {
    #     try {
    #         $Branch = git rev-parse --abbrev-ref HEAD
    #         if ($?) {
    #             $Status = (
    #                 git status --porcelain |
    #                 ConvertFrom-StringData -Delimiter " " |
    #                 Group-Object {$_.Keys} -NoElement |
    #                 ForEach-Object -Process { "{0}{1}" -f $_.Name[0], $_.Count }
    #             ) -join " "
    # 
    #             if ($Branch -eq "HEAD") {
    #                 # we're probably in detached HEAD state, so print the SHA
    #                 $Git = "{0}" -f (git rev-parse --short HEAD)
    #             }
    #             else {
    #                 # we're on an actual branch, so print it
    #                 $Git = "{0}" -f $Branch
    #             }
    # 
    #             if ($Status) {
    #                 $Git = "{0} {1}{2}" -f $Git, $PSReadLineOption.ListPredictionColor, $Status
    #             }
    #             "{0}({1}{0})`n" -f $PSReadLineOption.MemberColor, $Git
    #         }
    #     } catch {}
    # }.Invoke()

    # try {
    #     $PoshGitStatus = Get-GitStatus
    #     if ($PoshGitStatus) {
    #         $PoshGit = Write-GitStatus -Status $PoshGitStatus
    #         $PoshGit += "`n"
    #     }
    # }
    # catch {}

    "`r" +
    "${Timestamp} ${Path}`n" +
    "${PoshGit}" + "${PSVersion}${Prompt}"
}

