/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

public without sharing class FlowUUIDValidator {
  public class FlowInput {
    @InvocableVariable(required=true label='Unvalidated UUID Value')
    public String value;
  }

  @InvocableMethod(category='UUID' label='Validate UUID' description='Validates that the provided String is a valid UUID value')
  public static List<FlowUUID> validate(List<FlowInput> inputs) {
    List<FlowUUID> outputs = new List<FlowUUID>();
    for (FlowInput input : inputs) {
      FlowUUID output = new FlowUUID(input.value);
      outputs.add(output);
    }

    return outputs;
  }
}
