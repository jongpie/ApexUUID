@IsTest
private class Example_Flow_UUID_Generation_Tests {
  private static final String AUTOLAUNCHED_FLOW_NAME = 'Example_Flow_UUID_Generation';
  private static final String FLOW_INPUT_VARIABLE_UUID_VERSION = 'Target_UUID_Version';
  private static final String FLOW_OUTPUT_VARIABLE_UUID_IS_VALID = 'Generated_UUID_Is_Valid';
  private static final String FLOW_OUTPUT_VARIABLE_UUID_VALUE = 'Generated_UUID_Value';
  private static final String FLOW_OUTPUT_VARIABLE_UUID_VERSION = 'Generated_UUID_Version';

  @IsTest
  static void it_generates_uuid_in_flow_when_version_is_not_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>();
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.getDefaultVersion().name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.getDefaultVersion(), UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v1_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V1.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V1.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V1, UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v2_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V2.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V2.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V2, UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v3_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V3.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V3.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V3, UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v4_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V4.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V4.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V4, UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v5_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V5.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V5.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V5, UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v6_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V6.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V6.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V6, UUID.valueOf(generatedUuidValue).getVersion());
  }

  @IsTest
  static void it_generates_uuid_in_flow_when_version_v7_is_specified() {
    Map<String, Object> flowInputs = new Map<String, Object>{ FLOW_INPUT_VARIABLE_UUID_VERSION => UUID.Version.V7.name() };
    Flow.Interview testAutolaunchedFlow = Flow.Interview.createInterview(AUTOLAUNCHED_FLOW_NAME, flowInputs);

    testAutolaunchedFlow.start();

    Boolean generatedUuidIsValid = (Boolean) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_IS_VALID);
    String generatedUuidValue = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VALUE);
    String generatedUuidVersion = (String) testAutolaunchedFlow.getVariableValue(FLOW_OUTPUT_VARIABLE_UUID_VERSION);
    System.Assert.isTrue(generatedUuidIsValid);
    System.Assert.isTrue(UUID.isValid(generatedUuidValue));
    System.Assert.areEqual(generatedUuidValue, UUID.valueOf(generatedUuidValue).getValue());
    System.Assert.areEqual(UUID.Version.V7.name(), generatedUuidVersion);
    System.Assert.areEqual(UUID.Version.V7, UUID.valueOf(generatedUuidValue).getVersion());
  }
}
