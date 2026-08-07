@description('Location for all resources')
param location string = resourceGroup().location

@description('Name prefix for resources')
param namePrefix string = 'oai-sandbox'

@description('Unique suffix for resource names')
param uniqueSuffix string = uniqueString(resourceGroup().id)

var openAiName = '${namePrefix}-${uniqueSuffix}'

resource openAi 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: openAiName
  location: location
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: openAiName
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

output openAiEndpoint string = openAi.properties.endpoint
output openAiName string = openAi.name
output message string = 'OpenAI sandbox ready. Deploy your model from the playground.'
