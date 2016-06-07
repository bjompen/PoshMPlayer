@{
# Script module or binary module file associated with this manifest.
ModuleToProcess = 'PoshMPlayer.psm1'

# Version number of this module.
ModuleVersion = '0.1'

# ID used to uniquely identify this module
GUID = '4d549760-ffc6-4baf-b56c-9b8068b16bb7'

# Author of this module
Author = 'Björn Sundling'

# Copyright statement for this module
Copyright = 'DWIASYP - Do with it as you please lisence'

# Description of the functionality provided by this module
Description = 'A collection of tools to help you controll your mediaplayer (mainly spotify) without leaving your console'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Functions to export from this module
FunctionsToExport = @(
    'Send-VirtualKeyboard',
    'Invoke-Spotify',
    'Invoke-VLC',
    'Invoke-MediaPlayer',
    'Search-Spotify'
)

PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('Spotify','Mediaplayer')

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/bjompen/'

    }

}

}