/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

public without sharing class FlowUUIDValidator {
  public class FlowInput {
    @InvocableVariable(required=true label='Unvalidated UUID Value')
    public String value;
  }

  public class FlowOutput {
    @InvocableVariable(label='UUID Value Is Valid')
    public Boolean isValid;
    @InvocableVariable(label='UUID Value')
    public String value;
    @InvocableVariable(label='UUID Version')
    public String version;
  }

  @InvocableMethod(category='UUID' label='Validate UUID' description='Validates that the provided String is a valid UUID value')
  public static List<FlowOutput> validate(List<FlowInput> inputs) {
    List<FlowOutput> outputs = new List<FlowOutput>();
    for (FlowInput input : inputs) {
      FlowOutput output = new FlowOutput();
      output.isValid = UUID.isValid(input.value);

      if (output.isValid == true) {
        UUID uuidInstance = UUID.valueOf(input.value);
        output.value = uuidInstance.getValue();
        output.version = uuidInstance.getVersion().name();
      }

      outputs.add(output);
    }

    return outputs;
  }
}
