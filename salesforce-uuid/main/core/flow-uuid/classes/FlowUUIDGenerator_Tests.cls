@IsTest
private class FlowUUIDGenerator_Tests {
  @IsTest
  static void it_generates_uuid_when_version_is_not_specified() {
    Integer numberOfValuesToGenerate = 10;
    List<FlowUUIDGenerator.FlowInput> inputs = new List<FlowUUIDGenerator.FlowInput>();
    for (Integer i = 0; i < numberOfValuesToGenerate; i++) {
      FlowUUIDGenerator.FlowInput input = new FlowUUIDGenerator.FlowInput();
      inputs.add(input);
    }

    List<FlowUUIDGenerator.FlowOutput> generatedOutputs = FlowUUIDGenerator.generate(inputs);

    System.Assert.areEqual(numberOfValuesToGenerate, generatedOutputs.size());
    for (FlowUUIDGenerator.FlowOutput generatedOutput : generatedOutputs) {
      System.Assert.areEqual(UUID.getDefaultVersion().name(), generatedOutput.version);
    }
  }

  @IsTest
  static void it_generates_uuid_when_version_is_specified() {
    List<UUID.Version> targetVersions = UUID.Version.values();
    List<FlowUUIDGenerator.FlowInput> inputs = new List<FlowUUIDGenerator.FlowInput>();
    for (UUID.Version targetVersion : targetVersions) {
      FlowUUIDGenerator.FlowInput input = new FlowUUIDGenerator.FlowInput();
      input.version = targetVersion.name();
      inputs.add(input);
    }

    List<FlowUUIDGenerator.FlowOutput> generatedOutputs = FlowUUIDGenerator.generate(inputs);

    System.Assert.areEqual(targetVersions.size(), generatedOutputs.size());
    for (Integer i = 0; i < targetVersions.size(); i++) {
      UUID.Version targetVersion = targetVersions.get(i);
      FlowUUIDGenerator.FlowOutput generatedOutput = generatedOutputs.get(i);
      System.Assert.areEqual(targetVersion.name(), generatedOutput.version);
    }
  }
}
