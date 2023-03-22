/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

@IsTest
private class FlowUUIDValidator_Tests {
  @IsTest
  static void it_validates_when_value_is_valid() {
    Integer numberOfValuesToGenerate = 10;
    List<FlowUUIDValidator.FlowInput> inputs = new List<FlowUUIDValidator.FlowInput>();
    for (Integer i = 0; i < numberOfValuesToGenerate; i++) {
      FlowUUIDValidator.FlowInput input = new FlowUUIDValidator.FlowInput();
      input.value = new UUID().getValue();
      inputs.add(input);
    }

    List<FlowUUID> generatedOutputs = FlowUUIDValidator.validate(inputs);

    System.Assert.areEqual(numberOfValuesToGenerate, generatedOutputs.size());
    for (FlowUUID generatedOutput : generatedOutputs) {
      System.Assert.isTrue(generatedOutput.isValid);
      System.Assert.isNotNull(generatedOutput.value);
      System.Assert.areEqual(UUID.getDefaultVersion().name(), generatedOutput.version);
    }
  }

  @IsTest
  static void it_validates_when_value_is_not_valid() {
    Integer numberOfValuesToGenerate = 10;
    List<FlowUUIDValidator.FlowInput> inputs = new List<FlowUUIDValidator.FlowInput>();
    for (Integer i = 0; i < numberOfValuesToGenerate; i++) {
      FlowUUIDValidator.FlowInput input = new FlowUUIDValidator.FlowInput();
      input.value = 'some invalid value, index ' + i;
      inputs.add(input);
    }

    List<FlowUUID> generatedOutputs = FlowUUIDValidator.validate(inputs);

    System.Assert.areEqual(numberOfValuesToGenerate, generatedOutputs.size());
    for (FlowUUID generatedOutput : generatedOutputs) {
      System.Assert.isFalse(generatedOutput.isValid);
      System.Assert.isNull(generatedOutput.value);
      System.Assert.isNull(generatedOutput.version);
    }
  }
}
