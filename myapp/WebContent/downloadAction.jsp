<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="borad.BoradDAO"%>
<%@ page import="borad.Borad"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<title>취약한 웹 사이트</title>
</head>
<body>
	<%
		out.clear();
		out = pageContext.pushBody();
		
		request.setCharacterEncoding("UTF-8");
		
		String ID = null;
		String root = request.getSession().getServletContext().getRealPath("/");
		String savePath = root + "upload";
		
 		if(request.getParameter("ID") != null){
			ID = request.getParameter("ID");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 값입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 

 		Borad borad = new BoradDAO().getFILE(ID);
			
		/* String fileName = borad.getFILE(); */
		String Origin_FileName = borad.getOGIGIN_FILE(); 
		String fileName = request.getParameter("FILENAME");
		System.out.println(fileName);
		
		InputStream in = null;
		OutputStream os = null;
		File file = null;
		boolean skip = false;
		String client = "";
		
		try{
			try{
				file = new File(savePath, fileName);
				System.out.println(file);
				in = new FileInputStream(file);
			}catch(FileNotFoundException fe){
				skip = true;
			}
			
			client = request.getHeader("User-Agent");
			
			response.reset();
			response.setContentType("application/octet-stream");
			
			if(!skip){
				
				//IE
				if(client.indexOf("MSIE") != -1){
					response.setHeader("Content-Disposition", "attachment; filename="+new String(Origin_FileName.getBytes("KSC5601"),"ISO8859_1"));	
				}else{
					Origin_FileName = new String(Origin_FileName.getBytes("utf-8"),"iso-8859-1");
					
					response.setHeader("Content-Disposition", "attachment; filename=\"" + Origin_FileName + "\"");
					response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
				}
					response.setHeader("Content-Length", ""+file.length());
					
					os = response.getOutputStream();
					byte b[] = new byte[(int)file.length()];
					int leng = 0;
					
					while( (leng = in.read(b)) > 0){
						os.write(b,0,leng);
					}
				}else{
					response.setContentType("text/html;charset=UTF-8");
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert(파일을 찾을 수 없습니다.)");
					script.println("history.back()");
					script.println("</script>");
				}
				
				in.close();
				os.close();

				}catch(Exception e){
					e.printStackTrace();
				}
	%>
</body>
</html>