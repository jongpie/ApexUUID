@IsTest
private class Example_Flow_UUID_Generation_Tests {
  private static final String TEST_FLOW_NAME = 'Example_Flow_UUID_Generation';
  private static final String TEST_FLOW_GENERATED_UUID_VERSION_INPUT_VARIABLE_NAME = 'Target_UUID_Version';
  private static final String TEST_FLOW_GENERATED_UUID_OUTPUT_VARIABLE_NAME = 'Generated_UUID';

  @IsTest
  static void it_generates_uuid_in_flow_when_version_is_not_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>();
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(TEST_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(TEST_FLOW_GENERATED_UUID_OUTPUT_VARIABLE_NAME);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.getDefaultVersion(), UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v1_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ TEST_FLOW_GENERATED_UUID_VERSION_INPUT_VARIABLE_NAME => UUID.Version.V1.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(TEST_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(TEST_FLOW_GENERATED_UUID_OUTPUT_VARIABLE_NAME);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V1, UUID.valueOf(generatedUuidValue).getVersion());
  }
}
