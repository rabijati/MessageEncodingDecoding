<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Message Encoder/Decoder</title>
        <style><%@include file="/WEB-INF/css/style.css"%></style>

    </head>
    <body>

        <h2>Message Encoder/Decoder</h2>

        <form action="MessageEncoderDecoder" method="post" onsubmit="return validateForm()">
            <label for="option">Select an Option:</label>
            <select id="option" name="option">
                <option value="encode">Encode</option>
                <option value="decode">Decode</option>
            </select>
            <br><br>

            <label for="message">Message:</label>
            <input type="text" id="message" name="message" required>
            <br><br>

            <input type="submit" value="Submit">
        </form>

        <br><br>

        <% if (request.getAttribute("result") != null) {%>
        <table border="1">
           <tr>
                <th>Binary Representation</th>
                <td><%= request.getAttribute("binaryString")%></td>
            </tr>
             <tr>
                <th>Grouped Binary Representation</th>
                <td><%= request.getAttribute("groupedBinaryString")%></td>
            </tr>
            <tr>
                <th>Result</th>
                <td><%= request.getAttribute("result")%></td>
            </tr>           
            
            
        </table>
        <% }%>

        <script>
            function validateForEncode() {
                var message = document.getElementById("message").value;
                if (message.trim() === "") {
                    alert("Invalid input: Message cannot be empty for encoding");
                    return false;
                }
                return true;
            }

            function validateForDecode() {
                var encodedString = document.getElementById("message").value;
                var validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

                for (var i = 0; i < encodedString.length; i++) {
                    if (validChars.indexOf(encodedString.charAt(i)) === -1) {
                        alert("Invalid Base64 encoded string: Contains invalid character '" + encodedString.charAt(i) + "'  Remove the character!!!");
                        return false;
                    }
                }

                var paddingCount = 0;
                for (var j = encodedString.length - 1; j >= 0; j--) {
                    if (encodedString.charAt(j) === '=') {
                        paddingCount++;
                    } else {
                        break;
                    }
                }

                if (paddingCount > 2) {
                    alert("Invalid Base64 encoded string: Too many padding characters");
                    return false;
                }

                return true;
            }

            function validateForm() {
                var option = document.getElementById("option").value;

                if (option === "encode") {
                    return validateForEncode();
                } else {
                    return validateForDecode();
                }
            }
        </script>
    </body>
</html>
