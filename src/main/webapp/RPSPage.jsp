<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rock Paper Scissors</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        h2 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #555;
        }
        pre.ascii-art {
            font-family: monospace;
            text-align: left;
            display: inline-block;
            margin-bottom: 2rem;
            color: #333;
        }
        button {
            font-size: 1rem;
            padding: 0.75rem 1.5rem;
            margin: 0 0.5rem;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.1s;
        }
        button:hover {
            transform: scale(1.05);
        }
        #rock { background-color: #f44336; color: white; }
        #paper { background-color: #2196f3; color: white; }
        #scissors { background-color: #4caf50; color: white; }
    </style>
</head>
<body>
  <script>
  
    const socket = new WebSocket("ws://localhost:8080/Java.Tomcat.RPS/RPSRoomManager"); // ws:// is correct for WebSocket
    
    socket.onopen = function() {
      	console.log("WebSocket connected");
	  	const text = "roomId:"+"<% out.print(request.getParameter("enterRoom")); %>";
   		socket.send(text);
    };    

	socket.onmessage = function(event) {
      console.log("Received from server: " + event.data);
      const userCount = document.getElementById("userCount");
      //Logic to find if player joined or disconected
      userCount.textContent = event.data;
    };
    
    socket.onclose = function() {
    	
      console.log("WebSocket closed");
    };
    
    function sendMove(move) {
    	document.getElementById('played').value=move
    }
  </script>


    <h1>Rock Paper Scissors</h1>
    <h2>Room Id: <% out.print(request.getParameter("enterRoom")); %></h2>
    <h2 id="userCount">player count: 1/2</h2>
    <pre class="ascii-art">
    _______               _______                  _______
---'   ____)          ---'   ____)___          ---'   ____)____
      (_____)                  ______)                   ______)
      (_____)                  _______)                 _______)
      (____)                   _______)                 (___)
---.__(___)          ---.__________)            ---.___(___)


    </pre>
    <div>
		<form method="post">
  			<input type="hidden"  name="roomId" value="<% out.print(request.getParameter("enterRoom")); %>">
    		<input type="hidden" name="played" id="played" value="">
    		<button formaction="/Java.Tomcat.RPS/LoadingPage.jsp" type="submit" id="rock"  onclick="sendMove('Rock')">🪨 Rock</button>
    		<button formaction="/Java.Tomcat.RPS/LoadingPage.jsp" type="submit" id="paper" onclick="sendMove('Paper')">📄 Paper</button>
    		<button formaction="/Java.Tomcat.RPS/LoadingPage.jsp" type="submit" id="scissors" onclick="sendMove('Scissors')">✂️ Scissors</button>
  			
		</form>
    </div>
</body>
</html>
