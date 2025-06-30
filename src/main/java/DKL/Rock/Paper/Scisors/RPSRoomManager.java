package DKL.Rock.Paper.Scisors;

import java.io.IOException;
import java.util.Set;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/RPSRoomManager")
public class RPSRoomManager {
	private static final long serialVersionUID = 1L;
	public Integer userCount = 0;
	public String roomId = "";
	public Session matchedSession = null;
	public String played = "";

	@OnOpen
	public void onOpen(Session session) { // Log session connection
		System.out.println("Connected: session_" + session.getId());
	}

	@OnMessage
	public void onMessage(Session session, String msg) throws Exception { // Handle message
		System.out.println("");
		System.out.println("(session_" + session.getId() + ") message recieved: " + msg);
		// echo back the message
		if (msg.startsWith("roomId:")) // Join playroom
		{
			this.enterRoom(session, msg);
		}
		else if(msg.startsWith("waitingIn:") || msg.startsWith("played:")){
			if(msg.startsWith("waitingIn:"))
			{
				System.out.println("session_" + session.getId() +" waiting in " + msg.substring("waitingIn:".length()));
				this.roomId = msg.substring("waitingIn:".length());				
				this.enterRoom(session, "roomId:" + this.roomId);
			}
			else if(msg.startsWith("played:"))
			{
				this.played = msg.substring("played:".length());
				session.getUserProperties().put("played", this.played);
				System.out.println("played: " + this.played + " in room: " + this.roomId);
//				System.out.println("oponent (session_" + this.matchedSession.getId()+ " played:" + this.matchedSession.getUserProperties().get("played"));
				
				if (this.matchedSession != null && this.matchedSession.getUserProperties().containsKey("played"))
				{
					String opponentPlayed = (String) this.matchedSession.getUserProperties().get("played");
					System.out.println("both players in room made their move! Time to declare the winner!");
					
					this.matchedSession.getBasicRemote().sendText("opponent:"+this.played);
					session.getBasicRemote().sendText("opponent:"+ opponentPlayed );
					
					//calculate result
					this.matchedSession.getBasicRemote().sendText("result:"+this.getRPSresult(opponentPlayed, this.played));
					session.getBasicRemote().sendText("result:"+ this.getRPSresult(this.played, opponentPlayed));
					
					//send art
					this.matchedSession.getBasicRemote().sendText("playedArt:"+this.getArt(opponentPlayed));
					this.matchedSession.getBasicRemote().sendText("opponentArt:"+this.getArt(this.played));
					session.getBasicRemote().sendText("playedArt:"+this.getArt(this.played));
					session.getBasicRemote().sendText("opponentArt:"+ this.getArt(opponentPlayed));
					
					System.out.println("session_" + session.getId() +": "+this.played+", "+"session_" + matchedSession.getId() +": "+opponentPlayed);
					System.out.println("session_" + session.getId() + " result:"+ this.getRPSresult(this.played, opponentPlayed));
					
					this.matchedSession.getBasicRemote().sendText("redirect:http://localhost:8080/Java.Tomcat.RPS/ResultsPage.jsp");
					session.getBasicRemote().sendText("redirect:http://localhost:8080/Java.Tomcat.RPS/ResultsPage.jsp");
				}
			}
		}
	}
	private String getArt(String played)
	{
		String art ="";
		if (played == null) {
	        return "Invalid input!";
	    }
	    played = played.toLowerCase();
		
	    switch (played) 
	    {
        	case "rock":
art = """
    _______ 
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)
""";
        		break;
        	case "paper":
art = """
     _______      
 ---'   ____)___  
          ______) 
          _______)
          _______)
---.__________)   
	""";
        		break;
        	case "scissors":
art = """
    _______      
---'   ____)____ 
          ______)
         _______)
         (___)   
 ---.___(___)     
	""";
        		break;
        	default:
        		return "Invalid input!";
	    }
		
		return art;
	}
	private String getRPSresult(String played, String opponentPlayed) {
		
	    if (played == null || opponentPlayed == null) {
	        return "Invalid input!";
	    }
	    played = played.toLowerCase();
	    opponentPlayed = opponentPlayed.toLowerCase();
	    
	    if (played.equals(opponentPlayed)) {
	        return "It's a Draw!";
	    }
	    
	    switch (played) {
	        case "rock":
	            return opponentPlayed.equals("scissors") ? "You Win!" : "You Lose!";
	        case "paper":
	            return opponentPlayed.equals("rock") ? "You Win!" : "You Lose!";
	        case "scissors":
	            return opponentPlayed.equals("paper") ? "You Win!" : "You Lose!";
	        default:
	            return "Invalid input!";
	    }
	}

	private void enterRoom(Session session, String msg) throws Exception { // Handle joining play room
		this.roomId = msg.substring("roomId:".length());
		session.getUserProperties().put("roomId", roomId);
		System.out.println("(session_" + session.getId() + ") joining: " + this.roomId);

		matchedSession = this.findMatchedSession(session);
		
		if (matchedSession == null) {
			System.out.println("(session_" + session.getId() + ") no match found");
			return;
		} else {
			matchedSession.getBasicRemote().sendText("player count: 2/2");
			session.getBasicRemote().sendText("player count: 2/2");
			this.matchedSession = matchedSession;
		}
	}

	private Session findMatchedSession(Session session) throws Exception {
		Session matchedSession = null;
		Set<Session> sessions = session.getOpenSessions();
		for (Session peer : sessions) {
			if (peer.getId() == session.getId()) {
				continue;
			}
			if (peer.isOpen()) {
				if (((String) peer.getUserProperties().get("roomId")).equals(this.roomId)) {
					System.out.println("(session_" + session.getId() + ") room match with session_" + peer.getId());
					if (matchedSession == null) {
						matchedSession = peer;
					} else {
						session.getBasicRemote().sendText("This room is already full, try elsewhere");
						this.roomId = null;
						matchedSession = null;
						throw new Exception("room full: " + roomId);
					}
				}
			}
		}
		return matchedSession;
	}
	@OnClose
	public void onClose(Session session) throws IOException { // Handle disconnecting from room
		System.out.println("Session closed: session_" + session.getId() + " in room " + this.roomId);
		if (matchedSession != null && matchedSession.isOpen()) {
			matchedSession.getBasicRemote().sendText("player count: 1/2");
		}
	}
}