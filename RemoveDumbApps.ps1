$AppList = @(
    "*Microsoft.3dbuilder*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Microsoft.WindowsAlarms*"
    "*Microsoft.Asphalt8Airborne*"
    "*microsoft.windowscommunicationsapps*"
    "*Microsoft.WindowsCamera*"
    "*king.com.CandyCrushSodaSaga*"
    "*Microsoft.DrawboardPDF*"
    "*Facebook*"
    "*BethesdaSoftworks.FalloutShelter*"
    "*FarmVille2CountryEscape*"
    "*Microsoft.WindowsFeedbackHub*"
    "*Microsoft.GetHelp*"
    "*Microsoft.Getstarted*"
    "*Microsoft.ZuneMusic*"
    "*Microsoft.WindowsMaps*"
    "*Microsoft.Messaging"
    "*Microsoft.Wallet*"
    "*Microsoft.MicrosoftSolitaireCollection*"
    "*Todos*"
    "*ConnectivityStore*"
    "*MinecraftUWP*"
    "*Microsoft.OneConnect*"
    "*Microsoft.BingFinance*"
    "*Microsoft.ZuneVideo*"
    "*Microsoft.BingNews*"
    "*Microsoft.MicrosoftOfficeHub*"
    "*Netflix*"
    "*OneNote*"
    "*Microsoft.MSPaint*"
    "*PandoraMediaInc*"
    "*Microsoft.People*"
    "*CommsPhone*"
    "*windowsphone*"
    "*Microsoft.Print3D*"
    "*flaregamesGmbH.RoyalRevolt2*" 
    "*WindowsScan*"
    "*AutodeskSketchBook*"
    "*Microsoft.SkypeApp*"
    "*bingsports*"
    "*Office.Sway*"
    "*Microsoft.Getstarted*"
    "*Microsoft3DViewer*"
    "*Microsoft.WindowsSoundRecorder*"
    "*Microsoft.BingWeather*"
    "*Microsoft.XboxApp*"
    "*XboxOneSmartGlass*"
    "*Microsoft.XboxSpeechToTextOverlay*"
    "*Microsoft.XboxIdentityProvider*"
    "*Microsoft.XboxGameOverlay*"
)

foreach ($App in $AppList) {
    Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
} 