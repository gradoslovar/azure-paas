# parameters 
$rgName = "tm365"
$rgLocation = "West Europe"
$DeploymentName = "tm365Deployment"

# import the AzureRM modules
Import-Module AzureRM.TrafficManager
Import-Module AzureRM.Resources

#  login
# Login-AzureRmAccount

$scriptDir = Split-Path $MyInvocation.MyCommand.Path

New-AzureRmResourceGroup -Location $rgLocation `
                         -Name $rgName `
                         -Force -Verbose

New-AzureRmResourceGroupDeployment `
	-Name $DeploymentName `
	-ResourceGroupName $rgName `
    -TemplateFile "$scriptDir\geo.json" `
    -TemplateParameterFile "$scriptDir\geo.parameters.json" `
    -Verbose -Force
    #@additionalParameters


# Display the end result
$x = Get-AzureRmTrafficManagerProfile -ResourceGroupName $rgName
@"

##################################
##     Traffic Manager Info     ##
##################################"

"@
$x
@"

############################
##     Endpoints Info     ##
############################"

"@
$x.Endpoints