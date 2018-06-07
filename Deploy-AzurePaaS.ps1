# parameters 
$rgName = "app365"
$rgLocation = "West Europe"
$DeploymentName = "app365Deployment"

# import the AzureRM modules
#Import-Module AzureRM.TrafficManager
#Import-Module AzureRM.Resources

#  login
# Login-AzureRmAccount

# create the resource from the template - pass names as parameters
$scriptDir = Split-Path $MyInvocation.MyCommand.Path

New-AzureRmResourceGroup -Location $rgLocation `
                         -Name $rgName `
                         -Force -Verbose

New-AzureRmResourceGroupDeployment `
	-Name $DeploymentName `
	-ResourceGroupName $rgName `
    -TemplateFile "$scriptDir\main.json" `
    -TemplateParameterFile "$scriptDir\main.parameters.json" `
    -Verbose -Force
    #@additionalParameters

# deploy geo - Traffic Manager
# $scriptDir = Split-Path $MyInvocation.MyCommand.Path

# New-AzureRmResourceGroup -Location $rgLocation `
#                          -Name $rgName `
#                          -Force -Verbose

# New-AzureRmResourceGroupDeployment `
# 	-Name $DeploymentName `
# 	-ResourceGroupName $rgName `
#     -TemplateFile "$scriptDir\geo.json" `
#     -TemplateParameterFile "$scriptDir\geo.parameters.json" `
#     -Verbose -Force
#     #@additionalParameters


#  display the end result
# $x = Get-AzureRmTrafficManagerProfile -ResourceGroupName $rgName
# $x
# $x.Endpoints