<!DOCTYPE html>
<html>
<head>
  <title>WebSocket Test</title>
</head>
<body>

  <script>
    const socket = new WebSocket("ws://localhost:8080/Java.Tomcat.RPS/Echo"); // ws:// is correct for WebSocket
    socket.onopen = function() {
      console.log("WebSocket connected");
   		socket.send("hello");
   		console.log("hello sent");
    };
    socket.onmessage = function(event) {
      console.log("Received from server: " + event.data);
      const container = document.getElementById("echoContainer");
      const messageElement = document.createElement("p");
      messageElement.textContent = "Echo: " + event.data;
      container.appendChild(messageElement);
    };
    socket.onclose = function() {
      console.log("WebSocket closed");
    };

    function sendMessage() {
      const text = document.getElementById("msg").value;
      socket.send(text);
    }
  </script>

  <input id="msg" type="text" placeholder="Message">
  <button onclick="sendMessage()">Send</button>
  
  <div id="echoContainer"></div> <!-- Container for all echoed messages -->

</body>
</html>
