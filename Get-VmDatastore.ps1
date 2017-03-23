<# 
Get-VmDatastore
.Description
    Get virtual machine datastore infor
	russ 22/03/2017
    
.Example
    ./Get-VmInfo -VM <vmname>
#>


# Set file path, filename, date and time
# This is my standard path, you should adjust as needed
$datacenterName = get-datacenter
$filepath = "C:\PowerCLI\Output"
$filename = "$datacenterName" + "-VmDataStores"
$initalTime = Get-Date
$date = Get-Date ($initalTime) -uformat %Y%m%d
$time = Get-Date ($initalTime) -uformat %H%M

$csvName = "$filepath" + "$filename" + "$date$time" + ".csv"

Write-Host "---------------------------------------------------------" -ForegroundColor DarkYellow
Write-Host "Output will be saved to:"  								   -ForegroundColor Yellow
Write-Host $filepath$filename-$date$time".csv"  					   -ForegroundColor White
Write-Host "---------------------------------------------------------" -ForegroundColor DarkYellow




&{foreach($ds in Get-Datastore){
    Get-VM -Datastore $ds |
    Select Name,
        @{N='Datastore';E={$ds.Name}},
        @{N='VM on datastore';E={$ds.ExtensionData.Vm.Count}}
}} | Export-Csv $csvName -NoTypeInformation -UseCulture
Invoke-Item $csvName