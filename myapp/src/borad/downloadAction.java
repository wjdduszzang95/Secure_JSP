package borad;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class downloadAction
 */
@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public downloadAction() {
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ID = null;
		if (request.getParameter("ID")!=null){
			ID = request.getParameter("ID");
		}
		System.out.println(ID);	
		
		String savePath = this.getServletContext().getRealPath("/upload");
		
		
	}
}
	
	
	

