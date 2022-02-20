<% @page contentType="text/html" pageEncoding="UTF-8"%>
<% @page import="java.sql.*" %>
<%
 
		String custPwd = request.getParameter("pass");
		String custPhoneNum = request.getParameter("phoneNumber");
        String custEmail = request.getParameter("email");
		String custUsername = request.getParameter("username");

		try{
			Class.forName("org.postgresql.Driver");
			Connection con = DriverManager.getConnection("jdbc:postgresql://ec2-54-72-155-238.eu-west-1.compute.amazonaws.com:5432/d3lt7uttu2s0h3", "yyehssgxzsdqki","9e580d650d0f1be9f361083b5a0741807d83c7d92a887482a0630f19cd2dc9c3");
			//PreparedStatement pst = con.prepareStatement("insert into customers(custPwd, custPhoneNum, custEmail, custUsername)values(?,?,?,?)");
			Statement stmt=con.createStatement(); 
			String sql = "insert into customers(custPwd, custPhoneNum, custEmail, custUsername) values('"+custPwd+"','"+custPhoneNum+"','"+custEmail+"','"+custUsername+"')";
		
			/*pst.setString(1, custPwd);
			pst.setString(2, custPhoneNum);
			pst.setString(3, custEmail);
			pst.setString(4, custUsername);
			pst.executeUpdate();*/
			
			int x = stmt.executeUpdate(sql);
			if(x>0){
				response.sendRedirect("index.jsp");
			}else{
				request.setAttribute("error", "Error encountered. Try Again");
				RequestDispatcher rd = request.getRequestDispatcher("singUp.jsp");
				rd.include(request, response);
			}
			con.close();
		}catch(Exception e){
			out.println(e);
		}
        %>
