<% @page contentType="text/html" pageEncoding="UTF-8" %> 
<% @page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<body>
		<%
			String username2 = request.getParameter("username");
			String password2 = request.getParameter("password");
			
			try{ 
				//load the driver class  
				Class.forName("org.postgresql.Driver"); 
				
				//create the connection object 
				Connection con=DriverManager.getConnection("jdbc:postgresql://ec2-54-72-155-238.eu-west-1.compute.amazonaws.com:5432/d3lt7uttu2s0h3", "yyehssgxzsdqki","9e580d650d0f1be9f361083b5a0741807d83c7d92a887482a0630f19cd2dc9c3"); 
				String username = request.getParameter("username");
				String pass = request.getParameter("pass");
		
				//create the statement object 
				Statement stmt=con.createStatement(); 
				String sql = "select * from customers where custUsername= '" + username + "' and custPwd= '" + pass + "'";
				
				//execute query 
				ResultSet rs=stmt.executeQuery(sql); 

				//processing resultset - iterate
				if(rs.next()){
					String custID = rs.getString("custID");
					session.setAttribute("SES_ID",custID);
					response.sendRedirect("homepage.jsp");
				}
				else {
					request.setAttribute("error", "Wrong username or password. Try Again");
					RequestDispatcher rd = request.getRequestDispatcher("index.jsp"); 
					rd.include(request, response);
				} 
				con.close(); 
			}
			catch(Exception e){ 
				System.out.println(e); 
			} 
		%>
	</body>
</html>
