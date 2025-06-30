package DKL.Rock.Paper.Scisors;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RPS
 */
@WebServlet("/RPS")
public class RPS extends HttpServlet {
	
//	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public RPS() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
////		response.getWriter().append("Served at: ").append(request.getContextPath());
//		PrintWriter pw=response.getWriter();
//		response.setContentType("text/html");
//		pw.println("<h1>Hello world</h1>");
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int a = Integer.parseInt(request.getParameter("field1"));
		int b = Integer.parseInt(request.getParameter("field2"));
		int result = a + b;
		System.out.println(result);
		PrintWriter pw=response.getWriter();
		response.setContentType("text/html");
		pw.println("result: " + result);
	}

}
