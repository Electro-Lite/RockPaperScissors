<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Waiting for Opponent</title>
  <style>
    body {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      color: #333;
    }
    .spinner {
      width: 60px;
      height: 60px;
      border: 6px solid #ccc;
      border-top-color: #2196f3;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin-bottom: 20px;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
    h1 {
      font-size: 2rem;
      margin-bottom: 10px;
    }
    p {
      font-size: 1.2rem;
      color: #555;
    }
  </style>
</head>
<body>
<script>
const socket = new WebSocket("ws://localhost:8080/Java.Tomcat.RPS/RPSRoomManager");
let opponentPlayed;
let result;
let playedArt;
let opponentArt;
socket.onopen = function() {
    console.log("WebSocket connected");

    const text = "waitingIn:" + "<%= request.getParameter("roomId") %>";
    const text2 = "played:" + "<%= request.getParameter("played") %>";
    
    socket.send(text);
    socket.send(text2);
};

socket.onmessage = function(event) {
    console.log("Received from server: " + event.data);
    const userCount = document.getElementById("Played");
	const message = event.data;
    if (message.startsWith("redirect:")) {
        const url = message.substring("redirect:".length);
        redirectWithPost(url);
        return;
    }
    if (message.startsWith("opponent:")) {
    	opponentPlayed = message.substring("opponent:".length);
        return;
    }
    if (message.startsWith("result:")) {
    	result = message.substring("result:".length);
        return;
    }
    if (message.startsWith("opponentArt:")) {
    	opponentArt = message.substring("opponentArt:".length);
        return;
    }
    if (message.startsWith("playedArt:")) {
    	playedArt = message.substring("playedArt:".length);
        return;
    }
    // Update user count (or similar UI feedback)
    if (userCount) {
        userCount.textContent = event.data;
    }
};

function redirectWithPost(url) {
    const form = document.createElement("form");
    form.method = "POST";
    form.action = url;

    const roomIdField = document.createElement("input");
    roomIdField.type = "hidden";
    roomIdField.name = "roomId";
    roomIdField.value = "<%= request.getParameter("roomId") %>";
    
    const playedField = document.createElement("input");
    playedField.type = "hidden";
    playedField.name = "played";
    playedField.value = "<%= request.getParameter("played") %>";
    
    const playedArtField = document.createElement("input");
    playedArtField.type = "hidden";
    playedArtField.name = "playedArt";
    playedArtField.value = playedArt;
    
    const opponentField = document.createElement("input");
    opponentField.type = "hidden";
    opponentField.name = "opponentPlayed";
    opponentField.value = opponentPlayed;
    
    const opponentArtField = document.createElement("input");
    opponentArtField.type = "hidden";
    opponentArtField.name = "opponentArt";
    opponentArtField.value = opponentArt;
    
    const resultField = document.createElement("input");
    resultField.type = "hidden";
    resultField.name = "result";
    resultField.value = result;


    form.appendChild(roomIdField);
    form.appendChild(playedField);
    form.appendChild(playedArtField);
    form.appendChild(opponentField);
    form.appendChild(opponentArtField);
    form.appendChild(resultField);
    document.body.appendChild(form);
    form.submit();
}
</script>


  <div class="spinner"></div>
  <h1>Waiting for Opponent...</h1>
  <p>Your choice has been made. Waiting for the other player.</p>
    <h4>Room Id: <% out.print(request.getParameter("roomId")); %></h4>
    <h4 id="Played">Played: <% out.print(request.getParameter("played")); %></h4>
</body>
</html>
