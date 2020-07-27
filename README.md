# PSNewScript Description

PSNewScript file is a template script generator. Running this module will create a fully documented script file and save it out. This
will get you started quickly with using advanced functions and a fully functional script.

## Getting Started with GetPSGalleryModStats
1. First open a new PowerShell console as 'Administrator' and run the following command:
```powershell
cd c:\users\YourName\Documents\WindowsPowerShell\Modules
```
> This will take you to your user default PowerShell module directory

2. Run the following command:

```powershell
md PSNewScript
```
> This will create a new directory called PSNewScript.

3. Copy the contents of this project into this module directory

4. Run the following command:

```powershell
New-PSScript -ScriptName YourScriptName -NumberOfParameters <Value> -Notes "Your notes" -Synopsis "Your synopsis" -Description "Your description"
```

Enjoy!