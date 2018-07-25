/******************************************************************************************
* This file is part of the Apex UUID project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/jongpie/ApexUuid for full license details. *
******************************************************************************************/
public with sharing class Uuid {

    private static final Integer HEX_BASE                = HEX_CHARACTERS.length();
    private static final String HEX_CHARACTERS           = '0123456789ABCDEF';
    private static final List<String> HEX_CHARACTER_LIST = HEX_CHARACTERS.split('');
    private static final Integer UUID_V4_LENGTH          = 36;
    private static final String UUID_V4_REGEX            = '[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}';

    public static Boolean isEmpty(String uuidValue) {
        return String.isBlank(uuidValue) || uuidValue == '00000000-0000-0000-0000-000000000000';
    }

    public static Boolean isValid(String uuidValue) {
        if(isEmpty(uuidValue)) return false;
        if(uuidValue.length() != UUID_V4_LENGTH) return false;

        Pattern uuidPattern = Pattern.compile(UUID_V4_REGEX.toLowerCase());
        Matcher uuidMatcher = uuidPattern.matcher(uuidValue.toLowerCase());

        return uuidMatcher.matches();
    }

    public static Uuid valueOf(String uuidValue) {
        return new Uuid(uuidValue);
    }

    private static String formatValue(String unformattedValue) {
        // Remove any non-alphanumeric characters. Should be unnecessary, but better to be safe than sorry.
        unformattedValue = unformattedValue.replaceAll('[^a-zA-Z0-9]', '');

        // UUID Pattern: 8-4-4-4-12
        String formattedValue = unformattedValue.substring(0, 8)
            + '-' + unformattedValue.substring(8, 12)
            + '-' + unformattedValue.substring(12, 16)
            + '-' + unformattedValue.substring(16, 20)
            + '-' + unformattedValue.substring(20);

        return formattedValue.toLowerCase();
    }

    private final String value;

    public Uuid() {
        this.value = this.generateValue();
    }

    private Uuid(String uuidValue) {
        if(!isValid(uuidValue)) throw new UuidException(uuidValue + ' is not a valid UUID');

        this.value = formatValue(uuidValue);
    }

    public String getValue() {
        return this.value;
    }

    public override String toString() {
        return this.value;
    }

    private String generateValue() {
        String hex = EncodingUtil.convertToHex(Crypto.generateAesKey(128));

        // Version Calculation: (i & 0x0f) | 0x40
        // Version Format: Always begins with 4
        String versionShiftedHexBits = this.getShiftedHexBits(hex.substring(14, 16), this.convertHexToInteger('0x0f'), this.convertHexToInteger('0x40'));

        // Variant Calculation: (i & 0x3f) | 0x80
        // Variant Format: Always begins with one of 8,9,a,b
        String variantShiftedHexBits = this.getShiftedHexBits(hex.substring(18, 20), this.convertHexToInteger('0x3f'), this.convertHexToInteger('0x80'));

        String uuidValue =
            hex.substring(0, 8)                             // time-low
            + hex.substring(8, 12)                          // time-mid
            + versionShiftedHexBits + hex.substring(14, 16) // time-high-and-version
            + variantShiftedHexBits + hex.substring(18, 20) // clock-seq-and-reserved + clock-seq-low
            + hex.substring(20);                            //node

        return formatValue(uuidValue);
    }

    private String getShiftedHexBits(String hexSubstring, Integer lowerThreshold, Integer upperThreshold) {
        Integer shiftedIntegerBits = (this.convertHexToInteger(hexSubstring) & lowerThreshold) | upperThreshold;
        return this.convertIntegerToHex(shiftedIntegerBits);
    }

    private Integer convertHexToInteger(String hexValue) {
        hexValue = hexValue.toUpperCase();

        if(hexValue.startsWith('0X')) hexValue = hexValue.substringAfter('0X');

        Integer integerValue = 0;
        for(String hexCharacter : hexValue.split('')) {
            Integer characterIndex = HEX_CHARACTERS.indexOf(hexCharacter);
            integerValue = HEX_BASE * integerValue + characterIndex;
        }
        return integerValue;
    }

    private String convertIntegerToHex(Integer integerValue) {
        String hexValue = '';
        while(integerValue > 0) {
             Integer hexCharacterIndex = Math.mod(integerValue, HEX_BASE);
             hexValue = HEX_CHARACTER_LIST[hexCharacterIndex] + hexValue;
             integerValue = integerValue / HEX_BASE;
        }
        return hexValue;
    }

    private class UuidException extends Exception {}

}