/******************************************************************************************
 * This file is part of the Apex UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/ApexUuid for full license details. *
 ******************************************************************************************/

@IsTest(IsParallel=true)
private class UUID_Tests {
  @IsTest
  static void it_should_create_several_valid_uuids() {
    String generatedUuid = new UUID().getValue();
    System.assertEquals(36, generatedUuid.length());

    Pattern pattern = Pattern.compile('[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}');

    for (Integer i = 0; i < 10; i++) {
      UUID uuid = new UUID();
      Matcher matcher = pattern.matcher(uuid.getValue());
      System.assert(matcher.matches(), 'Generated UUID=' + uuid.getValue());
    }
  }

  @IsTest
  static void it_should_reuse_a_uuid_on_subsequent_calls() {
    UUID uuid = new UUID();
    String originalValue = uuid.getValue();

    for (Integer i = 0; i < 5; i++) {
      System.assertEquals(originalValue, uuid.getValue());
    }
  }

  @IsTest
  static void it_should_verify_that_a_uuid_is_a_uuid() {
    String generatedUuid = new UUID().getValue();
    System.assert(UUID.isValid(generatedUuid));
  }

  @IsTest
  static void it_should_not_consider_a_blank_string_a_uuid() {
    System.assertEquals(false, UUID.isValid(''));
  }

  @IsTest
  static void it_should_not_consider_null_a_uuid() {
    System.assertEquals(false, UUID.isValid(null));
  }

  @IsTest
  static void it_should_validate_a_uuid_in_upper_case() {
    String exampleUuid = 'f3665813-1a60-4924-ad9b-23a9cef17d80'.toUpperCase();
    System.assertEquals(true, UUID.isValid(exampleUuid));
  }

  @IsTest
  static void it_should_validate_a_uuid_in_lower_case() {
    String exampleUuid = 'f3665813-1a60-4924-ad9b-23a9cef17d80'.toLowerCase();
    System.assertEquals(true, UUID.isValid(exampleUuid));
  }

  @IsTest
  static void it_should_convert_a_valid_string_to_a_uuid() {
    String uuidValue = new UUID().getValue();

    Test.startTest();
    UUID convertedUuid = UUID.valueOf(uuidValue);
    Test.stopTest();

    System.assertEquals(uuidValue, convertedUuid.getValue());
  }

  @IsTest
  static void it_should_not_convert_an_invalid_string_to_a_uuid() {
    String invalidUuidValue = 'this-is-not-a-valid-uuid';

    Test.startTest();
    try {
      UUID convertedUuid = UUID.valueOf(invalidUuidValue);
      System.assert(false, 'Error expected here');
    } catch (Exception ex) {
      String expectedError = invalidUuidValue + ' is not a valid UUID';
      System.assert(ex.getMessage().contains(expectedError));
    }
    Test.stopTest();
  }
}
