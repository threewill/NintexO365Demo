# Introduction 
A PowerShell PnP based provisioning process used to creating a new site collection for demo'ing Nintex for Office 365 forms and workflows.

## Getting Started
First, you'll need to [Install PnP-PowerShell](https://github.com/SharePoint/PnP-PowerShell)

You also need access to a SharePoint Online Tenant with sufficient permissions to create a new site collection. It's highly recommended that an Office 365 Demo Tenant be used. A Free Demo Tenant can be created by using this link: [Microsoft Demos](https://demos.microsoft.com)

Finally, you'll need a DocuSign account. A 30 day trial can be obtained by visiting [THIS LINK](https://go.docusign.com/o/trial)

## Syntax
```powershell
./provision.ps1 -TenantName <String> 
                -OwnerEmail <String> 
                [-SiteName <String>] 
                [-SiteUrl <String>] 
```
## Parameters
Parameter|Type|Required|Description
---------|----|--------|-----------
|TenantName|String|True|The name of the tenant. (e.g. If your SPO Url is https://foo.sharepoint.com, you would enter 'foo')|
|OwnerEmail|String|True|The email address of the account that will be the primary owner and admin of the create site collection.|
|SiteName|String|False|The display name of the site you wish to create. Defaults to "Nintex Office 365 Demo"|
|SiteUrl|String|False|The tenant relative URL for the site collection you wish to create.|


## Examples
### Example 1
```powershell
./provision.ps1 -TenantName itrm492873 -OwnerEmail admin@itrm492873.onmicrosoft.com
```
Provisions a New Office 365 Site Collection titled 'Nintex Office 365 Demo', an Accounts list, a "Nintex Requests" list and with a group email address of pnp-demo-01@contoso.com.

### Example 2
```powershell
./provision.ps1 -ProjectCode "pnp-demo-01" -ProjectName "PnP Demo 01" -Description "Contoso PnP Team Site" 
```
Provisions a New Office 365 Group titled 'PnP Demo 01', a description of 'Contoso PnP Team Site', a team site at https://contoso.sharepoint.com/teams/pnp-demo-01, and with a group email address of pnp-demo-01@contoso.com.

### Creating a new Nintex Demo Site
#### Run the provisioning Script
* Open a PowerShell Window and set the directory to the folder containing the 'provision.ps1' script
```powershell
cd c:/github/NintexO365Demo
```
* Execute the script with whatever parameters necessary.
```powershell
./provision.ps1 -TenantName itrm492873 -OwnerEmail admin@itrm492873.onmicrosoft.com
```
* When prompted, enter the credentials for the tenant you wish to provision the site in.
![Microsoft Graph Login][msgraph-login]
* Wait for the script to finish.

#### Install the Nintex Apps
* Open the site you created in the browser and go to the Site Contents page.
* Click the "New" button from the ribbon and choose the "App" option.
* In the "Find an app" search box, type the word "Nintex" and press enter.
* Find and install both the "Nintex Forms for Office 365" and the "Nintex Workflow for Office 365" apps.
![Nintex Apps][nintex-apps]
* When prompted, trust both apps.

#### Add the Nintex Form to the 'Nintex Request List'
* Open the "Nintex Requests" list. 
* Click the "Nintex Forms" ribbon button.
* Click the "Nintex Requests New List Workflow" button.
* Click the "Import" button from the ribbon.
* Find and open the /Nintex Files/NintexForm.nfp file.
* Click the "Publish" button. 
* Close the Form Designer

#### Add the Nintex Workflow to the 'Nintex Request List'
* Open the "Nintex Requests" list. 
* Click the "Nintex Workflow" ribbon button.
* Click the "Nintex Requests/New list workflow" button.
* Click the "Import" button from the ribbon.
* Find and open the /Nintex Files/Nintex Request Approval.nwp file.
* Double Click the "Tenant Variables" action.
* Update the 'Tenant Name' variable to match your environment.
* Update the MOD Admin Login name and password if you're using a different account.
* Click the Save Button
* Double Click the "DocuSign Variables" action.
* Update the email addresses as necessary.
* Click the "Publish" button. 
* Close the Workflow Designer
 
### Developer Notes
Currently, this project uses the '2016-05' version of the [PnP Provisioning-Schema](https://github.com/SharePoint/PnP-Provisioning-Schema)

[Click Here to view a sample](https://github.com/SharePoint/PnP-Provisioning-Schema/blob/master/Samples/ProvisioningSchema-2016-05-FullSample-02.xml) 

[msgraph-login]: https://github.com/threewill/NintexO365Demo/blob/master/images/pnp-msgraph-login.jpg "Microsoft Graph Login Window"
[nintex-apps]: https://github.com/threewill/Nintex0365Demo/blob/master/images/nintex-apps.jpg "Nintex for Office 365 Apps"