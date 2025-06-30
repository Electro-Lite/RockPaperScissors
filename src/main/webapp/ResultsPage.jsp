<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RPS Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }
        h1.result {
            font-size: 3rem;
            margin-bottom: 2rem;
            color: #333;
        }
        .ascii-container {
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin-bottom: 2rem;
        }
        pre.ascii-art {
            font-family: monospace;
            text-align: left;
            color: #333;
            background-color: #f0f0f0;
            padding: 1rem;
            border-radius: 0.5rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .button-container {
            margin-top: 2rem;
        }
        button {
            font-size: 1rem;
            padding: 0.75rem 1.5rem;
            margin: 0 1rem;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.1s;
        }
        button:hover {
            transform: scale(1.05);
        }
        #play-again {
            background-color: #4caf50;
            color: white;
        }
        #leave-room {
            background-color: #f44336;
            color: white;
        }
    </style>
</head>
<body>
<script>
	const socket = new WebSocket("ws://localhost:8080/Java.Tomcat.RPS/RPSRoomManager");
	
	socket.onopen = function() {
      	console.log("WebSocket connected");
	  	const text = "waitingIn:"+"<% out.print(request.getParameter("roomId")); %>";
   		socket.send(text);
    };
</script>
    
    <h1 class="result"><% out.print(request.getParameter("result")); %></h1>

    <div class="ascii-container">
        <div>
            <h2>Your Choice:</h2>
            <pre class="ascii-art">
<% out.print(request.getParameter("playedArt")); %>
            </pre>
            <% out.print(request.getParameter("played")); %>
        </div>
        <div>
            <h2>Opponent's Choice:</h2>
            <pre class="ascii-art">
<% out.print(request.getParameter("opponentArt")); %>
            </pre>
			<% out.print(request.getParameter("opponentPlayed")); %>
        </div>
    </div>

    <div class="button-container">
        <form method="post">
            <input type="hidden" name="enterRoom" value="<% out.print(request.getParameter("roomId")); %>">
            <button id="play-again" type="submit" formaction="http://localhost:8080/Java.Tomcat.RPS/RPSPage.jsp">🔁 Play Again</button>
            <button id="leave-room" type="submit" formaction="http://localhost:8080/Java.Tomcat.RPS/LoginPage.jsp">🚪 Leave Room</button>
        </form>
    </div>

</body>
</html>
