/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

public without sharing class FlowUUID {
  @AuraEnabled
  @InvocableVariable
  public Boolean isValid;
  @AuraEnabled
  @InvocableVariable
  public String value;
  @AuraEnabled
  @InvocableVariable
  public String version;

  public FlowUUID() {
    // No-op
  }

  public FlowUUID(String uuidValue) {
    this.isValid = UUID.isValid(uuidValue);

    if (this.isValid == true) {
      UUID uuidInstance = UUID.valueOf(uuidValue);
      this.value = uuidInstance.getValue();
      this.version = uuidInstance.getVersion().name();
    }
  }

  public FlowUUID(UUID uuidInstance) {
    this.isValid = true;
    this.value = uuidInstance.getValue();
    this.version = uuidInstance.getVersion().name();
  }
}
