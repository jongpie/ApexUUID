/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

public without sharing class FlowUUIDGenerator {
  public class FlowInput {
    @InvocableVariable(required=false label='(Optional) UUID Version')
    public String version;
  }

  @InvocableMethod(category='UUID' label='Generate UUID' description='Creates a UUID value')
  public static List<FlowUUID> generate(List<FlowInput> inputs) {
    List<FlowUUID> outputs = new List<FlowUUID>();
    for (FlowInput input : inputs) {
      UUID.Version uuidVersion = String.isBlank(input.version) == true ? UUID.getDefaultVersion() : UUID.Version.valueOf(input.version);
      UUID uuidInstance = new UUID(uuidVersion);

      FlowUUID output = new FlowUUID(uuidInstance);
      outputs.add(output);
    }
    return outputs;
  }
}
