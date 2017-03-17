<#
.SYNOPSIS

Provisions a new site collection in a SharePoint Online tenant and applies a template, creating support lists and libraries for a demo of Nintex for Office 365

.DESCRIPTION

Script creates a new site collection in a SharePoint online tenant, provisions several lists, libraries, and content used to support a a demo of Nintex for Office 365.
Does not provision the Nintex Apps, nor does it create or publish any workflows. For that, follow the steps in the included README markdown file.

.PARAMETER TenantName 
REQUIRED
<string>

The name of the tenant. (e.g. If your SPO Url is https://foo.sharepoint.com, you would enter 'foo')

.PARAMETER OwnerEmail
REQUIRED
<string>

The email address of the account that will be the primary owner and admin of the create site collection.

.PARAMETER SiteName
OPTIONAL
<string>

The display name of the site you wish to create. Defaults to "Nintex Office 365 Demo"

.PARAMETER SiteUrl
OPTIONAL
<string>

The tenant relative URL for the site collection you wish to create.

.EXAMPLE

Standard example providing only the required information
./provision.ps1 -TenantName itrm492873 -OwnerEmail admin@itrm492873.onmicrosoft.com

.EXAMPLE

Standard example specifying a non-default Site Name and non-default Site Url
./provision.ps1 -TenantName itrm351667 -OwnerEmail admin@itrm351667.onmicrosoft.com -SiteName "My Demo Name" -SiteUrl "/sites/MySiteUrl"

.NOTES

There is about a 10 minute waiting period while SharePoint fully provisions the site collection. 
#>

param(
    [string]$TenantName,
    [string]$OwnerEmail,
    [string]$SiteName = "Nintex Office 365 Demo",
    [string]$SiteUrl = "/sites/NintexO365Demo"
)
Set-PnPTraceLog -On -Level Debug -LogFile ".\TraceLogs\$(Get-Date -Format FileDateTime).log"
$SiteUrl = "https://$($TenantName).sharepoint.com$($SiteUrl)"
$TenantUrl = "https://$($TenantName)-admin.sharepoint.com"
$waiting = $true
try{
    Write-Host "Connecting to '$TenantUrl'..." -NoNewline
    Connect-PnPOnline -Url $TenantUrl -UseWebLogin
    Write-Host "Connected!" -ForegroundColor Green

    Write-Host "Creating new site collection at $SiteUrl (this takes about 10 minutes)..." -NoNewline
    New-PnPTenantSite -Title $SiteName -Url $SiteUrl -Owner $OwnerEmail -TimeZone 10 -Template "STS#0" -ErrorAction Stop            
    
    #We have to wait for the site collection to be available.
    while($waiting){
        try{            
            Connect-PnPOnline -Url $SiteUrl -UseWebLogin -ErrorAction Stop
            $waiting = $false
        }
        catch{
            Write-Host "." -NoNewline
            Start-Sleep -Seconds 30
        }
    }
    Write-Host "Completed" -ForegroundColor Green
   
    Write-Host "Applying Template to Site..." -NoNewline
    Apply-PnPProvisioningTemplate -Path "schema.xml" -ErrorAction Stop 
    Write-Host "Completed!" -ForegroundColor Green            
}
catch{
    #Have to catch and throw error yourself to stop the script from executing.
    Write-Host "Failed" -ForegroundColor Red    
    throw $_     
}

