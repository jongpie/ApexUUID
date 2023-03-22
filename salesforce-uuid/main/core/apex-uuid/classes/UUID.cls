/*************************************************************************************************
 * This file is part of the Salesforce UUID project, released under the MIT License.             *
 * See LICENSE file or go to https://github.com/jongpie/SalesforceUUID for full license details. *
 ************************************************************************************************/

public without sharing class UUID {
  // TODO switch to using v7 as default version (once v7 has been implemented)
  private static final Version DEFAULT_VERSION = Version.V4;
  private static final Integer HEX_BASE = HEX_CHARACTERS.length();
  private static final String HEX_CHARACTERS = '0123456789abcdef';
  private static final String HEX_PREFIX = '0x';
  private static final List<String> HEX_CHARACTER_LIST = HEX_CHARACTERS.split('');
  private static final Integer UUID_LENGTH = 36;
  @TestVisible
  private static final String REGEX_ALL_VERSIONS = '[0-9a-f]{8}-[0-9a-f]{4}-[0-9]{1}[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';
  private static final Map<Version, System.Type> VERSION_TO_GENERATOR_TYPE = new Map<Version, System.Type>{
    Version.V1 => UUIDv1.class,
    Version.V2 => UUIDv2.class,
    Version.V3 => UUIDv3.class,
    Version.V4 => UUIDv4.class,
    Version.V5 => UUIDv5.class,
    Version.V6 => UUIDv6.class,
    Version.V7 => UUIDv7.class
  };

  public enum Version {
    V1,
    V2,
    V3,
    V4,
    V5,
    V6,
    V7
  }

  private String value;
  private Version uuidVersion;

  public UUID() {
    this(DEFAULT_VERSION);
  }

  public UUID(Version uuidVersion) {
    this.uuidVersion = uuidVersion;
    this.setValue(this.getGenerator(uuidVersion).generateValue());
  }

  private UUID(String uuidValue) {
    this.setValue(uuidValue);
  }

  public String getValue() {
    return this.value;
  }

  public override String toString() {
    return this.getValue();
  }

  public Version getVersion() {
    if (this.uuidVersion == null) {
      // For UUID instances that have been generated using UUID.valueOf(String),
      // the version of the UUID has to be determined based on the provided String value.
      // When a UUID is formatted as 8-4-4-12, the version number of the UUID is
      // stored as the 14th character, so we can extract it from the provided String value.
      Integer versionNumber = Integer.valueOf(this.getValue().substring(14, 15));
      this.uuidVersion = UUID.Version.valueOf('V' + versionNumber);
    }
    return this.uuidVersion;
  }

  private UUIDGenerator getGenerator(Version uuidVersion) {
    return (UUIDGenerator) VERSION_TO_GENERATOR_TYPE.get(uuidVersion).newInstance();
  }

  private void setValue(String uuidValue) {
    this.value = UUID.formatValue(uuidValue);
  }

  private abstract class UUIDGenerator {
    public abstract String generateValue();

    protected String getShiftedHexBits(String hexSubstring, Integer lowerThreshold, Integer upperThreshold) {
      Integer shiftedIntegerBits = (this.convertHexToInteger(hexSubstring) & lowerThreshold) | upperThreshold;
      return this.convertIntegerToHex(shiftedIntegerBits);
    }

    protected Integer convertHexToInteger(String hexValue) {
      hexValue = hexValue.toLowerCase();
      if (hexValue.startsWith(HEX_PREFIX)) {
        hexValue = hexValue.substringAfter(HEX_PREFIX);
      }

      Integer integerValue = 0;
      for (String hexCharacter : hexValue.split('')) {
        Integer hexCharacterIndex = HEX_CHARACTERS.indexOf(hexCharacter);
        integerValue = HEX_BASE * integerValue + hexCharacterIndex;
      }
      return integerValue;
    }

    protected String convertIntegerToHex(Integer integerValue) {
      String hexValue = '';
      while (integerValue > 0) {
        Integer hexCharacterIndex = Math.mod(integerValue, HEX_BASE);

        hexValue = HEX_CHARACTER_LIST[hexCharacterIndex] + hexValue;
        integerValue = integerValue / HEX_BASE;
      }
      return hexValue;
    }
  }

  private class UUIDv1 extends UUIDGenerator {
    public override String generateValue() {
      return 'TODO Implement v1';
    }
  }

  private class UUIDv2 extends UUIDGenerator {
    public override String generateValue() {
      return 'TODO Implement v2';
    }
  }

  private class UUIDv3 extends UUIDGenerator {
    public override String generateValue() {
      return 'TODO Implement v3';
    }
  }

  private class UUIDv4 extends UUIDGenerator {
    public override String generateValue() {
      String hexValue = System.EncodingUtil.convertToHex(System.Crypto.generateAesKey(128));

      // Version Calculation: (i & 0x0f) | 0x40
      // Version Format: Always begins with 4
      String versionShiftedHexBits = this.getShiftedHexBits(hexValue.substring(14, 16), this.convertHexToInteger('0x0f'), this.convertHexToInteger('0x40'));

      // Variant Calculation: (i & 0x3f) | 0x80
      // Variant Format: Always begins with 8, 9, A or B
      String variantShiftedHexBits = this.getShiftedHexBits(hexValue.substring(18, 20), this.convertHexToInteger('0x3f'), this.convertHexToInteger('0x80'));

      String uuidValue =
        hexValue.substring(0, 8) + // time-low
        hexValue.substring(8, 12) + // time-mid
        versionShiftedHexBits +
        hexValue.substring(14, 16) + // time-high-and-version
        variantShiftedHexBits +
        hexValue.substring(18, 20) + // clock-seq-and-reserved + clock-seq-low
        hexValue.substring(20); // node

      return UUID.formatValue(uuidValue);
    }
  }

  private class UUIDv5 extends UUIDGenerator {
    public override String generateValue() {
      return 'TODO Implement v5';
    }
  }

  private class UUIDv6 extends UUIDGenerator {
    public override String generateValue() {
      return 'TODO Implement v6';
    }
  }

  private class UUIDv7 extends UUIDGenerator {
    public override String generateValue() {
      return 'TODO Implement v7';
    }
  }

  /* Static methods */
  public static String formatValue(String unformattedValue) {
    // Remove any non-alphanumeric characters
    String originalValue = unformattedValue;
    unformattedValue = unformattedValue?.replaceAll('[^a-zA-Z0-9]', '');

    // If the unformatted value isn't even the right length to be valid, then throw an exception
    // Subtract 4 because the UUID_LENGTH includes 4 '-' characters in the UUID pattern
    if (String.isBlank(unformattedValue) == true || unformattedValue.length() != (UUID_LENGTH - 4)) {
      throwInvalidValueException(originalValue);
    }

    // UUID Pattern: 8-4-4-4-12
    String formattedValue = String.format(
        '{0}-{1}-{2}-{3}-{4}',
        new List<String>{
          unformattedValue.substring(0, 8),
          unformattedValue.substring(8, 12),
          unformattedValue.substring(12, 16),
          unformattedValue.substring(16, 20),
          unformattedValue.substring(20)
        }
      )
      .toLowerCase();

    validate(formattedValue, originalValue);
    return formattedValue;
  }

  public static Version getDefaultVersion() {
    return DEFAULT_VERSION;
  }

  public static Boolean isValid(String uuidValue) {
    if (String.isBlank(uuidValue) == true || uuidValue.length() != UUID_LENGTH) {
      return false;
    }

    System.Pattern uuidPattern = System.Pattern.compile(REGEX_ALL_VERSIONS);
    return uuidPattern.matcher(uuidValue.toLowerCase()).matches();
  }

  public static void validate(String formattedValue, String originalValue) {
    if (!UUID.isValid(formattedValue)) {
      throwInvalidValueException(originalValue);
    }
  }

  public static UUID valueOf(String uuidValue) {
    return new UUID(uuidValue);
  }

  private static void throwInvalidValueException(String uuidValue) {
    final String invalidValueError = uuidValue + ' is not a valid UUID value';
    throw new IllegalArgumentException(invalidValueError);
  }
}
