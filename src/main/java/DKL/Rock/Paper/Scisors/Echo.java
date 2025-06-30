package DKL.Rock.Paper.Scisors;

import java.io.IOException;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

/**
 * Servlet implementation class Echo
 */
@ServerEndpoint("/Echo")
public class Echo {
	private static final long serialVersionUID = 1L;
       
    @OnOpen
    public void onOpen(Session session) {
        System.out.println("Connected: " + session.getId());
    }
    @OnMessage
    public void onMessage(Session session, String msg) throws IOException {
        // echo back the message
		System.out.println("hello");
    }
    @OnClose
    public void onClose(Session session) {
        System.out.println("Session closed: " + session.getId());
    }

}
