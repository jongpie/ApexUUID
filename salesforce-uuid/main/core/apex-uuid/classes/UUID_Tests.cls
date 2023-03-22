/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

@SuppressWarnings('PMD.MethodNamingConventions')
@IsTest(IsParallel=true)
private class UUID_Tests {
  private static final String REGEX_V1 = '[0-9a-f]{8}-[0-9a-f]{4}-1[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final String REGEX_V2 = '[0-9a-f]{8}-[0-9a-f]{4}-2[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final String REGEX_V3 = '[0-9a-f]{8}-[0-9a-f]{4}-3[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final String REGEX_V4 = '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final String REGEX_V5 = '[0-9a-f]{8}-[0-9a-f]{4}-5[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final String REGEX_V6 = '[0-9a-f]{8}-[0-9a-f]{4}-6[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final String REGEX_V7 = '[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';

  @IsTest
  static void it_should_return_v4_as_default_version() {
    //TODO update this method name & assert to use v7, once v7 has been implemented
    System.Assert.areEqual(UUID.Version.V4, UUID.getDefaultVersion());
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_default_version() {
    //TODO update this method name & assert to use v7, once v7 has been implemented
    System.Pattern v4Pattern = System.Pattern.compile(REGEX_V4);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID();

      System.Assert.areEqual(UUID.getDefaultVersion(), generatedUuid.getVersion());
      System.Matcher matcher = v4Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v1() {
    System.Pattern v1Pattern = System.Pattern.compile(REGEX_V1);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v1);

      System.Assert.areEqual(UUID.Version.V1, generatedUuid.getVersion());
      System.Matcher matcher = v1Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v2() {
    System.Pattern v2Pattern = System.Pattern.compile(REGEX_V2);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v2);

      System.Assert.areEqual(UUID.Version.V2, generatedUuid.getVersion());
      System.Matcher matcher = v2Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v3() {
    System.Pattern v3Pattern = System.Pattern.compile(REGEX_V3);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v3);

      System.Assert.areEqual(UUID.Version.V3, generatedUuid.getVersion());
      System.Matcher matcher = v3Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v4() {
    System.Pattern v4Pattern = System.Pattern.compile(REGEX_V4);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v4);

      System.Assert.areEqual(UUID.Version.V4, generatedUuid.getVersion());
      System.Matcher matcher = v4Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v5() {
    System.Pattern v5Pattern = System.Pattern.compile(REGEX_V5);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v5);

      System.Assert.areEqual(UUID.Version.V5, generatedUuid.getVersion());
      System.Matcher matcher = v5Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v6() {
    System.Pattern v6Pattern = System.Pattern.compile(REGEX_V6);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v6);

      System.Assert.areEqual(UUID.Version.V6, generatedUuid.getVersion());
      System.Matcher matcher = v6Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_create_valid_uuids_when_using_v7() {
    System.Pattern v7Pattern = System.Pattern.compile(REGEX_V7);
    for (Integer i = 0; i < 10; i++) {
      UUID generatedUuid = new UUID(UUID.Version.v7);

      System.Assert.areEqual(UUID.Version.V7, generatedUuid.getVersion());
      System.Matcher matcher = v7Pattern.matcher(generatedUuid.getValue());
      String assertMessage = 'Invalid value for ' + generatedUuid.getVersion().name() + ', generated UUID value: ' + generatedUuid.getValue();
      System.Assert.isTrue(matcher.matches(), assertMessage);
    }
  }

  @IsTest
  static void it_should_cache_uuid_value_on_subsequent_calls() {
    UUID generatedUuid = new UUID();

    String originalValue = generatedUuid.getValue();

    for (Integer i = 0; i < 5; i++) {
      String assertMessage = 'UUID value should be cached & reused, expected ' + originalValue + ', received ' + generatedUuid.getValue();
      System.Assert.areEqual(originalValue, generatedUuid.getValue(), assertMessage);
    }
  }

  @IsTest
  static void it_should_return_uuid_value_when_stringified() {
    UUID generatedUuid = new UUID();
    String expectedStringValue = generatedUuid.getValue();

    String coercedStringResult = 'Some string' + generatedUuid;
    String stringValueOfResult = String.valueOf(generatedUuid);
    String toStringResult = generatedUuid.toString();

    System.Assert.areEqual(expectedStringValue, coercedStringResult);
    System.Assert.areEqual(expectedStringValue, stringValueOfResult);
    System.Assert.areEqual(expectedStringValue, toStringResult);
  }

  @IsTest
  static void it_should_verify_that_a_uuid_value_is_a_uuid() {
    String generatedUuid = new UUID().getValue();

    System.Assert.isTrue(UUID.isValid(generatedUuid));
  }

  @IsTest
  static void it_should_not_consider_a_blank_string_a_uuid() {
    System.Assert.isFalse(UUID.isValid(''), 'Empty string should not be considered a valid value');
  }

  @IsTest
  static void it_should_not_consider_null_a_uuid() {
    System.Assert.isFalse(UUID.isValid(null), 'null string should not be considered a valid value');
  }

  @IsTest
  static void it_should_return_false_when_value_is_not_valid() {
    String invalidUuidValue = 'This is not a valid UUID, it\'s just some text, and also an emoji 😀 or 2️⃣';

    System.Assert.isFalse(UUID.isValid(invalidUuidValue));
  }

  @IsTest
  static void it_should_return_true_when_valid_value_is_in_upper_case() {
    String validUuidValue = 'F3665813-1A60-4924-AD9B-23A9CEF17D80';

    System.Assert.isTrue(UUID.isValid(validUuidValue));
  }

  @IsTest
  static void it_should_return_true_when_valid_value_is_in_lower_case() {
    String validUuidValue = 'f3665813-1a60-4924-ad9b-23a9cef17d80';

    System.Assert.isTrue(UUID.isValid(validUuidValue));
  }

  @IsTest
  static void it_should_convert_a_valid_string_to_a_uuid() {
    String uuidValue = new UUID().getValue();

    UUID convertedUuid = UUID.valueOf(uuidValue);

    System.Assert.areEqual(uuidValue, convertedUuid.getValue());
  }

  @IsTest
  static void it_should_throw_illegal_argument_exception_when_converting_an_invalid_string_to_a_uuid() {
    String invalidUuidValue = 'this-is-not-a-valid-uuid';

    try {
      UUID convertedUuid = UUID.valueOf(invalidUuidValue);
      System.Assert.fail('Error expected in line above, this error should never occur');
    } catch (IllegalArgumentException ex) {
      String expectedError = invalidUuidValue + ' is not a valid UUID';
      System.Assert.isTrue(ex.getMessage().contains(expectedError), 'Unexpected error thrown: ' + ex.getMessage());
    }
  }
}
