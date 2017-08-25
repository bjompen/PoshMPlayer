Function LoginBrowser($URI) {
    Add-Type -AssemblyName System.Windows.Forms
    $FormProperties = @{
        Size = New-Object System.Drawing.Size(850, 675)
        StartPosition = "CenterScreen"
    }
    $Form = New-Object System.Windows.Forms.Form -Property $FormProperties

    $BrowserProperties = @{
        Dock = "Fill"
    }

    $Browser = New-Object System.Windows.Forms.WebBrowser -Property $BrowserProperties
    
    $Form.Controls.Add($Browser)
    $Browser.Navigate($URI)
    $Form.Add_Shown({$Form.Activate()})

    $null = $Form.ShowDialog()
    
    if ($Browser.url.Fragment -match "access_token=(.*)&token") {
        $AccessToken = $Matches[1]
        $Token = @{Authorization = "Bearer $AccessToken"}
        $Token
        $Browser.Dispose()
        $Form.Dispose()
    }
    else {
        $Browser.Dispose()
        $Form.Dispose()
        throw 'No token received'
    }
}

function Connect-Spotify
{
    [CmdletBinding()]
    [OutputType('System.String')]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$ClientId,
        
        [string]$RedirectUri = 'http://localhost/',

        [string]$Scope = 'scope=playlist-modify-public playlist-modify-private playlist-read-private playlist-read-collaborative streaming'
    )

    Begin
    {
        $AuthUri = "https://accounts.spotify.com/en/authorize/?"
        $ClientId ="client_id=$ClientId"
        $RedirectUri = "redirect_uri=$RedirectUri"
        $Response = "response_type=token"

        $URI = ('{0}{1}&{2}&{3}&{4}' -f $AuthUri,$ClientId,$RedirectUri,$Scope,$Response)
    }
    Process
    {
        Try { 
            $AccessToken = LoginBrowser -URI $URI
        }
        catch {
            Write-Error $_
        }
    }
    End
    {
        $AccessToken
    }
}
