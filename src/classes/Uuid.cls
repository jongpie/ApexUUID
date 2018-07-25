/******************************************************************************************
* This file is part of the Apex UUID project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/jongpie/ApexUuid for full license details. *
******************************************************************************************/
public with sharing class Uuid {

    public static Boolean isEmpty(String uuidValue) {
        return String.isBlank(uuidValue) || formatValue(uuidValue) == '00000000-0000-0000-0000-000000000000';
    }

    public static Boolean isValid(String uuidValue) {
        if(isEmpty(uuidValue)) return false;

        final String UUID_V4_REGEX = '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';

        Pattern uuidPattern = Pattern.compile(UUID_V4_REGEX.toLowerCase());
        Matcher uuidMatcher = uuidPattern.matcher(uuidValue.toLowerCase());

        return uuidMatcher.matches();
    }

    private static String formatValue(String unformattedValue) {
        // Remove any non-alphanumeric characters. Should be unnecessary, but better to be safe than sorry.
        unformattedValue = unformattedValue.replaceAll('[^a-zA-Z0-9]', '');

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

    public String getValue() {
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

        // UUID Pattern: 8-4-4-4-12
        String uuidValue =
            hex.substring(0, 8)                                   // time-low
            + '-' + hex.substring(8, 12)                          // time-mid
            + '-' + versionShiftedHexBits + hex.substring(14, 16) // time-high-and-version
            + '-' + variantShiftedHexBits + hex.substring(18, 20) // clock-seq-and-reserved + clock-seq-low
            + '-' + hex.substring(20);                            //node

        return uuidValue.toLowerCase();
    }

    public String getShiftedHexBits(String hexSubstring, Integer lowerThreshold, Integer upperThreshold) {
        Integer shiftedIntegerBits = (this.convertHexToInteger(hexSubstring) & lowerThreshold) | upperThreshold;
        return this.convertIntegerToHex(shiftedIntegerBits);
    }

    // Apex version of https://introcs.cs.princeton.edu/java/31datatype/Hex2Decimal.java.html
    public Integer convertHexToInteger(String hex) {
        String hexCharacters = '0123456789ABCDEF';
        hex = hex.toUpperCase();
        if(hex.startsWith('0X')) hex = hex.substringAfter('0X');
        Integer integerValue = 0;
        for(String hexCharacter : hex.split('')) {
            Integer characterIndex = hexCharacters.indexOf(hexCharacter);
            integerValue = 16 * integerValue + characterIndex;
        }
        return integerValue;
    }

    public String convertIntegerToHex(Integer integerValue) {
        List<String> hexCharacters = '0123456789ABCDEF'.split('');
        String hs0 = hexCharacters[integerValue & this.convertHexToInteger('0x0f')];
        String hs1 = hexCharacters[(integerValue >> this.convertHexToInteger('0x04')) & this.convertHexToInteger('0x0f')];
system.debug('hs0=' + hs0);
system.debug('hs1=' + hs1);
        return hs1 + hs0;
    }

}