<%@ page import="com.chat.servlet.LoginServlet" %>
<%@ page session="true" errorPage="error.jsp" %>
<%
    String nickname = (String) session.getAttribute(LoginServlet.ATTRIBUTE_NICKNAME);
    if (nickname != null && nickname.length() > 0) {
%>

<HTML>
<HEAD>
    <TITLE>WEB Chat - <%=nickname%></TITLE>
</HEAD>
<FRAMESET rows="80%,20%">
    <FRAME SRC="displayMessages.jsp#current" name="MessageWin">
    <FRAME SRC="sendMessage.jsp" name="TypeWin">
</FRAMESET>
<NOFRAMES>
    <H2>This chat rquires a browser with frames support</h2>
</NOFRAMES>
</HTML>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>