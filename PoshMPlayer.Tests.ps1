# Extra thank you to Jakub Jareš / @PSPester for the howto!
# https://gist.github.com/nohwnd/c8e72858905c70f2558bfb1eefb403a9
#
# Make sure KeybdEvent.win32utils isn´t loaded before running the test.

Get-Module PoshMPlayer | Remove-Module -Force
Import-Module .\PoshMPlayer.psd1 -Force
InModuleScope PoshMPlayer { 
    $resultMock = @"
{
  "albums" : {
    "href" : "https://api.spotify.com/v1/search?query=Dysangelic&offset=0&limit=20&type=album",
    "items" : [ {
      "album_type" : "album",
      "available_markets" : [ "CA", "CR", "DO", "GT", "HN", "MX", "NI", "PA", "SV", "US" ],
      "external_urls" : {
        "spotify" : "https://open.spotify.com/album/4uTBXQnCK9rT8CVfxwtgnw"
      },
      "href" : "https://api.spotify.com/v1/albums/4uTBXQnCK9rT8CVfxwtgnw",
      "id" : "4uTBXQnCK9rT8CVfxwtgnw",
      "images" : [ {
        "height" : 640,
        "url" : "https://i.scdn.co/image/c6633cee7e024b73ac3a66c11d51b2785628e7bf",
        "width" : 640
      }, {
        "height" : 300,
        "url" : "https://i.scdn.co/image/837e7c11a0887be861f8b46f5c8d48ba15e9ed02",
        "width" : 300
      }, {
        "height" : 64,
        "url" : "https://i.scdn.co/image/a8ba003bd00e62c71f496640a1d8fc8468682f5c",
        "width" : 64
      } ],
      "name" : "The Dysangelic Principle",
      "type" : "album",
      "uri" : "spotify:album:4uTBXQnCK9rT8CVfxwtgnw"
    } ],
    "limit" : 20,
    "next" : null,
    "offset" : 0,
    "previous" : null,
    "total" : 2
  },
  "artists" : {
    "href" : "https://api.spotify.com/v1/search?query=Dysangelic&offset=0&limit=20&type=artist",
    "items" : [ {
      "external_urls" : {
        "spotify" : "https://open.spotify.com/artist/2s4F23oKx966ieaOiR1Rmc"
      },
      "followers" : {
        "href" : null,
        "total" : 21
      },
      "genres" : [ ],
      "href" : "https://api.spotify.com/v1/artists/2s4F23oKx966ieaOiR1Rmc",
      "id" : "2s4F23oKx966ieaOiR1Rmc",
      "images" : [ {
        "height" : 640,
        "url" : "https://i.scdn.co/image/f40ddbc09b3dcf3f4f6993a46fdddaa6bd10f484",
        "width" : 640
      }, {
        "height" : 300,
        "url" : "https://i.scdn.co/image/c7e33eff5691353f20c688a8aeef7cb3543bcd32",
        "width" : 300
      }, {
        "height" : 64,
        "url" : "https://i.scdn.co/image/31bbc37a5d424c1f74447d8bfd6ef5cc385998da",
        "width" : 64
      } ],
      "name" : "Dysangelic",
      "popularity" : 0,
      "type" : "artist",
      "uri" : "spotify:artist:2s4F23oKx966ieaOiR1Rmc"
    } ],
    "limit" : 20,
    "next" : null,
    "offset" : 0,
    "previous" : null,
    "total" : 1
  },
  "tracks" : {
    "href" : "https://api.spotify.com/v1/search?query=Dysangelic&offset=0&limit=20&type=track",
    "items" : [ {
      "album" : {
        "album_type" : "single",
        "available_markets" : [ "AR", "AU", "AT", "BE", "BO", "BR", "BG", "CA", "CL", "CO", "CR", "CY", "CZ", "DK", "DO", "DE", "EC", "EE", "SV", "FI", "FR", "GR", "GT", "HN", "HK", "HU", "IS", "IE", "IT", "LV", "LT", "LU", "MY", "MT", "MX", "NL", "NZ", "NI", "NO", "PA", "PY", "PE", "PH", "PL", "PT", "SG", "SK", "ES", "SE", "CH", "TW", "TR", "UY", "US", "GB", "AD", "LI", "MC", "ID" ],
        "external_urls" : {
          "spotify" : "https://open.spotify.com/album/2m99UEpGGwdBNtq2ItVpFY"
        },
        "href" : "https://api.spotify.com/v1/albums/2m99UEpGGwdBNtq2ItVpFY",
        "id" : "2m99UEpGGwdBNtq2ItVpFY",
        "images" : [ {
          "height" : 640,
          "url" : "https://i.scdn.co/image/f40ddbc09b3dcf3f4f6993a46fdddaa6bd10f484",
          "width" : 640
        }, {
          "height" : 300,
          "url" : "https://i.scdn.co/image/c7e33eff5691353f20c688a8aeef7cb3543bcd32",
          "width" : 300
        }, {
          "height" : 64,
          "url" : "https://i.scdn.co/image/31bbc37a5d424c1f74447d8bfd6ef5cc385998da",
          "width" : 64
        } ],
        "name" : "Return to the End",
        "type" : "album",
        "uri" : "spotify:album:2m99UEpGGwdBNtq2ItVpFY"
      },
      "artists" : [ {
        "external_urls" : {
          "spotify" : "https://open.spotify.com/artist/2s4F23oKx966ieaOiR1Rmc"
        },
        "href" : "https://api.spotify.com/v1/artists/2s4F23oKx966ieaOiR1Rmc",
        "id" : "2s4F23oKx966ieaOiR1Rmc",
        "name" : "Dysangelic",
        "type" : "artist",
        "uri" : "spotify:artist:2s4F23oKx966ieaOiR1Rmc"
      } ],
      "available_markets" : [ "AR", "AU", "AT", "BE", "BO", "BR", "BG", "CA", "CL", "CO", "CR", "CY", "CZ", "DK", "DO", "DE", "EC", "EE", "SV", "FI", "FR", "GR", "GT", "HN", "HK", "HU", "IS", "IE", "IT", "LV", "LT", "LU", "MY", "MT", "MX", "NL", "NZ", "NI", "NO", "PA", "PY", "PE", "PH", "PL", "PT", "SG", "SK", "ES", "SE", "CH", "TW", "TR", "UY", "US", "GB", "AD", "LI", "MC", "ID" ],
      "disc_number" : 1,
      "duration_ms" : 373995,
      "explicit" : false,
      "external_ids" : {
        "isrc" : "FR6V81617390"
      },
      "external_urls" : {
        "spotify" : "https://open.spotify.com/track/5tAUSkFBKg00z2Xyk9Fdja"
      },
      "href" : "https://api.spotify.com/v1/tracks/5tAUSkFBKg00z2Xyk9Fdja",
      "id" : "5tAUSkFBKg00z2Xyk9Fdja",
      "name" : "Void of Silence",
      "popularity" : 0,
      "preview_url" : "https://p.scdn.co/mp3-preview/837252d7f96eac612d4e58e1ca966f8723187d24",
      "track_number" : 3,
      "type" : "track",
      "uri" : "spotify:track:5tAUSkFBKg00z2Xyk9Fdja"
    } ],
    "limit" : 20,
    "next" : null,
    "offset" : 0,
    "previous" : null,
    "total" : 11
  },
  "playlists" : {
    "href" : "https://api.spotify.com/v1/search?query=Dysangelic&offset=0&limit=20&type=playlist",
    "items" : [ ],
    "limit" : 20,
    "next" : null,
    "offset" : 0,
    "previous" : null,
    "total" : 0
  }
}
"@
    

    
    Describe 'search-spotify' { 
        Mock Invoke-WebRequest {return $resultMock}
        
        it 'tests that album is correct, using search for anything' {
            ((Search-Spotify Dysangelic).albums)[0].Name | Should be 'The Dysangelic Principle'
        }
    
        it 'tests that qery for artist responds as expected' {
            (Search-Spotify dysangelic -Type artist).Name | Should be 'Dysangelic'
        }
    
        it 'tests that correct uri is returned when searching for track' {
            $res = Search-Spotify dysangelic -Type track |select -Last 1 | % uri 
            $Res | should be 'spotify:track:5tAUSkFBKg00z2Xyk9Fdja'
        }
    
        it 'makes shure the mock has been used..' {
            Assert-MockCalled -CommandName Invoke-WebRequest -Exactly 3
        }
    }
    
    add-type -TypeDefinition @"
        using System;
        public static class KeyboardEventTestUtil {
            public static string keybd_event(byte bVk, byte bScan, UInt32 dwFlags, System.UIntPtr dwExtraInfo) {
                return string.Format("{0}:{1}:{2}:{3}", bVk,bScan,dwFlags,dwExtraInfo);
            }
        }
"@
    Describe 'send-VirtualKeyboard' {
    
        mock add-type {return [KeyboardEventTestUtil]
        }
    
        It 'sends a keystroke "a"' {
            [char][int](Send-VirtualKeyboard -key 0x41).split(':')[0]| Should be 'a'
        }
        It 'sends a keystroke "b"' {
            [char][int](vkey -key 0x42).split(':')[0]| Should be 'b'
        }
        It 'Checks that the mock has been used' {
            Assert-MockCalled -CommandName Add-Type -Exactly 2
        }
    
    }
}