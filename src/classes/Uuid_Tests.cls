@isTest
private class Guid_Tests {

    @isTest
    static void it_should_consider_all_zeroes_string_to_be_empty() {
        System.assert(Guid.isEmpty('00000000-0000-0000-0000-000000000000'));
    }

    @isTest
    static void it_should_create_a_new_guid() {
        String generatedGuid = Guid.createGuid();
        System.assertEquals(36, generatedGuid.length());
    }

    @isTest
    static void it_should_verify_that_a_guid_is_a_guid() {
        String generatedGuid = Guid.createGuid();
        System.assert(Guid.isGuid(generatedGuid));
    }

    @isTest
    static void it_should_consider_null_string_an_empty_guid() {
        System.assert(Guid.isEmpty(null));
    }

    @isTest
    static void it_should_not_consider_an_empty_string_a_guid() {
        System.assertEquals(false, Guid.isGuid(''));
    }

    @isTest
    static void it_should_not_consider_null_a_guid() {
        System.assertEquals(false, Guid.isGuid(null));
    }

    @isTest
    static void it_should_validate_a_guid_in_upper_case() {
        String exampleGuid = 'f3665813-1a60-4924-ad9b-23a9cef17d80'.toUpperCase();
        System.assertEquals(true, Guid.isGuid(exampleGuid));
    }

    @isTest
    static void it_should_validate_a_guid_in_lower_case() {
        String exampleGuid = 'f3665813-1a60-4924-ad9b-23a9cef17d80'.toLowerCase();
        System.assertEquals(true, Guid.isGuid(exampleGuid));
    }
}