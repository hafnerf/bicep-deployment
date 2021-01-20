param location string = resourceGroup().location
param namePrefix string = 'stg'
param globalRedundancy bool = true
var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'

resource storage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  kind: 'StorageV2'
  location: location
  name: storageAccountName
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${storage.name}/default/logs'
}

output storageId string = storage.id
output storageName string = storage.name
output storageEndpoing string = storage.properties.primaryEndpoints.blob