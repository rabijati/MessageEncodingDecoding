/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package encoderdecoder;

public class Decoder {

	public Decoder() {
	}

	public String decoded(String encodedText) {
		String binaryString = convertToBinaryString(encodedText);
		String decodedString = decodeBinaryToString(binaryString);
		return decodedString.toString();
	}

	public String convertToBinaryString(String encodedText) {
		StringBuilder binaryString = new StringBuilder();
		for (char c : encodedText.toCharArray()) {
			try {
				int decimalValue = getDecimalValue(c);
				String binary = Integer.toBinaryString(decimalValue);
				while (binary.length() < 6) {
					binary = "0" + binary;
				}
				binaryString.append(binary);
			} catch (IllegalArgumentException e) {
				System.out.println("Invalid character: " + c + ". Skipping...");
			}
		}
		return binaryString.toString();
	}

	public String decodeBinaryToString(String binaryString) {
		StringBuilder decodedString = new StringBuilder();
		for (int i = 0; i < binaryString.length(); i += 8) {
			String group = binaryString.substring(i, Math.min(i + 8, binaryString.length()));
			int decimalValue = Integer.parseInt(group, 2);
			char decodedChar = (char) decimalValue;
			decodedString.append(decodedChar);
		}
		return decodedString.toString();
	}

	public String groupBinaryString(String binaryString) {
		StringBuilder groupedBinaryString = new StringBuilder();
		int index = 0;

		while (index < binaryString.length()) {
			String group = binaryString.substring(index, Math.min(index + 6, binaryString.length()));
			while (group.length() < 6) {
				group += "0";
			}
			groupedBinaryString.append(group).append(" ");
			index += 6;
		}

		return groupedBinaryString.toString().trim();
	}

	public int getDecimalValue(char base64Char) {
		if (base64Char >= 'A' && base64Char <= 'Z') {
			return base64Char - 'A';
		} else if (base64Char >= 'a' && base64Char <= 'z') {
			return base64Char - 'a' + 26;
		} else if (base64Char >= '0' && base64Char <= '9') {
			return base64Char - '0' + 52;
		} else if (base64Char == '+') {
			return 62;
		} else if (base64Char == '/') {
			return 63;
		} else {
			throw new IllegalArgumentException("Invalid Base64 character: " + base64Char);
		}
	}
}
