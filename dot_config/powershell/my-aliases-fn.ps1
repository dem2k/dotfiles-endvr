## wer hat sich nur diese aliase ausgedacht? idioten!
Remove-Item alias:curl -ErrorAction SilentlyContinue
Remove-Item alias:wget -ErrorAction SilentlyContinue
 
## meine aliases & functions
function ll { Get-ChildItem -Force }
Set-Alias l get-childitem

# Set-Alias doom c:\users\x004123\.emacs.d\bin\doom.ps1
# Set-Alias emacs D:\PortableApps\Emacs\bin\emacs.exe
# Set-Alias ec D:\PortableApps\Emacs\bin\emacsclientw.exe
# Set-Alias emacsclient D:\PortableApps\Emacs\bin\emacsclientw.exe
# Set-Alias vi c:\scoop\apps\neovim\current\bin\nvim.exe
# Set-Alias nvim c:\scoop\apps\neovim\current\bin\nvim.exe
# Set-Alias more c:\scoop\apps\git\current\usr\bin\less.exe
# Set-Alias more d:\portableapps\tools\bat.exe

# ## meine functionen
# function lf { c:\scoop\apps\lf\current\lf.exe -print-last-dir|cd }
# function gll { git.exe log --graph --pretty=format:"%C(auto)%h%<(3)%d %s %C(bold blue)(%cr, %an)%Creset" --abbrev-commit --all }

