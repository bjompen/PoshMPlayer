<#
.Synopsis
   Send virtual keystroke to host
.DESCRIPTION
   Sends virtual keystroke using byte value of virtual key codes found here
   https://msdn.microsoft.com/en-us/library/windows/desktop/dd375731%28v=vs.85%29.aspx

   Using the 'action' parameter you can also do some pre-defined actions using the keys from an extended keyboard.

.EXAMPLE
   Send-VirtualKeyboard -action 'VolMute'

   This command will mute the volume on your computer
.EXAMPLE
   vkey 'StartMP'

   This command will start the default set media player of your computer
.EXAMPLE
    Send-VirtualKeyboard -key 0x41

    This command will send the keystroke with value 0x41 (A key) to your console.
    This can be used to send and key input defined in the list of virtual keycodes.
    https://msdn.microsoft.com/en-us/library/windows/desktop/dd375731%28v=vs.85%29.aspx
.NOTES
    You can also refer to Send-VirtualKeyboard by its built in alias "vkey"
.LINK
    https://msdn.microsoft.com/en-us/library/windows/desktop/dd375731%28v=vs.85%29.aspx
.LINK
    https://msdn.microsoft.com/en-us/library/windows/desktop/ms646304%28v=vs.85%29.aspx
.LINK
    http://www.kbdedit.com/manual/low_level_vk_list.html

#>
function Send-VirtualKeyboard
{
    [cmdletbinding(DefaultParameterSetName=’action’)]
    [Alias('vkey')]
    [OutputType([void])]
    Param
    (
        # Specifies a key to send to console.
        [Parameter(Mandatory = $true,
                   parametersetname = 'key',
                   Position = 0)]
        [byte]$key,

        # Specifies a preset action to perform.
        [Parameter(Mandatory = $true,
                   parametersetname = 'action',
                   Position = 0)]
                   [ValidateSet('Play/Pause','Stop','Next','prev','VolUp','VolDown','VolMute','StartMP','StartApp1','StartApp2','PrtScn','NumLock','ScrollLock','CapsLock')]
        [String]$action
    )

    Begin
    {
        [byte]$KeyUpEvent   = 0x0002
        [byte]$KeyDownEvent = 0x0001
        
        [byte]$Play         = 0xB3
        [byte]$Stop         = 0xB2
        [byte]$Next         = 0xB0
        [byte]$prev         = 0xB1
        [byte]$VolUp        = 0xAF
        [byte]$VolDown      = 0xAE
        [byte]$VolMute      = 0xAD
        [byte]$StartMP      = 0xB5
        
        [byte]$StartApp1    = 0xB6
        [byte]$StartApp2    = 0xB7
        [byte]$PrtScn       = 0x2C
        [byte]$NumLock      = 0x90
        [byte]$ScrollLock   = 0x91
        [byte]$CapsLock     = 0x14

        $keybd = @'
            [DllImport("user32.dll")]
            public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
'@
            Try
            { 
                IF (! ('KeybdEvent.Win32Utils' -as [type]) )
                { 
                    $type = Add-Type -MemberDefinition $keybd -Name Win32Utils -Namespace KeybdEvent -PassThru 
                }
                ELSE
                {
                    $type = 'KeybdEvent.win32utils' -as [Type]
                }
            }
            catch
            {
                Write-Error 'Failed to pInvoke user32.dll'
                $_.Exception.message
                break
            }
    }
    Process
    {
        Switch ($PSCmdlet.ParameterSetName)
        {
            'action' 
            {
                Switch ($action)
                {
                    'Play/Pause' { $KeyPressed = $Play        }
                    'Stop'       { $KeyPressed = $Stop        }
                    'Next'       { $KeyPressed = $Next        }
                    'prev'       { $KeyPressed = $prev        }
                    'VolUp'      { $KeyPressed = $VolUp       }
                    'VolDown'    { $KeyPressed = $VolDown     }
                    'VolMute'    { $KeyPressed = $VolMute     }
                    'StartMP'    { $KeyPressed = $StartMP     }
                    'StartApp1'  { $KeyPressed = $StartApp1   }
                    'StartApp2'  { $KeyPressed = $StartApp2   }
                    'PrtScn'     { $KeyPressed = $PrtScn      }
                    'NumLock'    { $KeyPressed = $NumLock     }
                    'ScrollLock' { $KeyPressed = $ScrollLock  }
                    'CapsLock'   { $KeyPressed = $CapsLock    }
                }                                
            }

            'key' {
                $KeyPressed = [byte]$key
            }
        
        }

        $type::keybd_event($KeyPressed,0,$KeyDownEvent,[System.UIntPtr]::Zero)
        $type::keybd_event($KeyPressed,0,$KeyUpEvent,[System.UIntPtr]::Zero)
    }
    End
    {
    }
}

function PlaySpotify 
{
    Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        public class FgWindow {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
        }
"@
    $PoshWindow = (Get-Process –id $pid).MainWindowHandle
    [FgWindow]::SetForegroundWindow((Get-Process -Name spotify | Where-Object {[int]$($_.MainWindowHandle) -gt 1 } | Select-Object -First 1 -ExpandProperty MainWindowHandle)) | out-null
    vkey -key 0x0D
    Start-Sleep -Seconds 1
    [FgWindow]::SetForegroundWindow($PoshWindow) | Out-Null
}

function Invoke-Spotify
{
    param
    (
          # Specifies a URI to send to spotify. Can be found using Search-Spotify.
          [Parameter(Mandatory = $False,
          Position = 0)]
          [String]$Uri,

          # If set, tries to start the selected URI by switching windows and presing 'enter'. Only works with Track URIs
          [Parameter(Mandatory = $False)]
          [switch]$Play
    )
    IF ($Uri)
    {
        & "$env:APPDATA\Spotify\Spotify.exe" --uri=$uri
    }
    ELSE
    {
        & "$env:APPDATA\Spotify\Spotify.exe"
    }

    IF ($Play)
    {
        IF (($uri -split ':')[1] -EQ 'track')
        {
            PlaySpotify
        }
        Else
        {
            Write-Verbose 'You appear to have sent no URI, or not a track URI. Unfortunately I can´t play those yet.'
        }
    }
 
}

function Invoke-VLC
{
    param
    (
        [Parameter(Mandatory = $False,
          Position = 0)]
          [ValidateScript({Test-Path $_ -PathType Leaf})]
          [String]$StartFile
    )

    $VLCPath = Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\VideoLAN\VLC | Select-Object -ExpandProperty '(default)'
    & $VLCPath $StartFile
}

Function Invoke-MediaPlayer
{
    param
    (
        [Parameter(Mandatory = $False,
          Position = 0)]
          [ValidateScript({Test-Path $_ -PathType Leaf})]
          [String]$StartFile
    )

    & "${env:ProgramFiles(x86)}\Windows Media Player\wmplayer.exe" $StartFile
}

<#
.Synopsis
   Search for spotifylinks
.DESCRIPTION
   Finds Albums, Artists, Tracks and Playlists from spotify using spotify web api.
   Pipe the URI of the object you want to play to invoke-spotify to open it.
   You can use advanced querys to fetch more detailed results.
.EXAMPLE
   Search-Spotify Dysangelic

   This command will return a HashTable with artists, albums, playlists and tracks matching the exact query 'Dysangelic'
.EXAMPLE
   Search-Spotify -Query '*Dysangelic*' -Type Album

   This command will return a object containing Albums matching the query '*Dysangelic*' with wildcards (*)
.EXAMPLE
   Search-Spotify -Query 'artist:dysangelic album:the dysangelic principle' -Type Any

   This command will return a HashTable matching the spotify query variant 'artist:dysangelic album:the dysangelic principle'
   Note that spotify query uses the format '<type>:<term> <type>:<term>' with spaces.
   common querys include, but is not limited to:
    artist:
    album:
    track:
    genre:
    year:
   Some of these are exclusive and can not be combined. Try as you may, success may vary.
#>
function Search-Spotify
{
    [CmdletBinding()]
    Param
    (
        # Searchquery, Wildcard "*" is supported.
        [Parameter(Mandatory=$True,
        Position = 0)]
        [string]$Query,

        # Limits the result to the matching type of data.
        [Parameter(Mandatory=$false,
        Position = 1)]
        [ValidateSet('album','artist','playlist','track','all')]
        [string]$Type = 'all'

    )

    Begin
    {
        
    }
    Process
    {
        Switch ($Type)
        {
           'album'     { $SearchType = [string]'album' }
           'artist'    { $SearchType = [string]'artist' }
           'playlist'  { $SearchType = [string]'playlist' }
           'track'     { $SearchType = [string]'track' }
           'all'       { $SearchType = [string]'album,artist,playlist,track' }
        }

        $Uri = "https://api.spotify.com/v1/search?q=$Query&type=$SearchType"
        try
        { 
            $QueryResult = Invoke-WebRequest -Uri $Uri | ConvertFrom-Json
        }
        catch
        {
            Write-Error 'Failed to fetch data from Spotify'
            $_.Exception.Message
        }
        
                Switch ($Type)
        {
           'album'     { $Result = $QueryResult.albums.items }
           
           'artist'    { $Result = $QueryResult.artists.items }
           
           'playlist'  { $Result = $QueryResult.playlists.items }
           
           'track'     { $Result = $QueryResult.tracks.items }
           
           'all'       { $Result = @{ 'albums'=$QueryResult.albums.items 
                                      'artists'=$QueryResult.artists.items 
                                      'playlists'=$QueryResult.Playlists.items 
                                      'tracks'=$QueryResult.tracks.items }
                       }
        }
        
    }
    End
    {
        $Result
    }
}
