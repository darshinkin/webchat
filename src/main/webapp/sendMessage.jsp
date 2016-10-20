<%@page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="cp1251"%>
<%@ page isErrorPage="false" errorPage="error.jsp" %>
<%@ page import="com.chat.Chatter" %>
<%@ page import="com.chat.servlet.LoginServlet" %>
<%@ page import="com.chat.Message" %>
<%@ page import="com.chat.ChatRoom" %>


<%
    ChatRoom chatRoom = (ChatRoom) application.getAttribute(LoginServlet.ATTRIBUTE_CHATROOM);
    String nickname = (String) session.getAttribute(LoginServlet.ATTRIBUTE_NICKNAME);
    Chatter chatter;
    if (nickname != null) {
        chatter = chatRoom.getChatter(nickname);
        String msg = request.getParameter(LoginServlet.PARAMETER_MESSAGESBOX);
        if (msg != null && msg.length() > 0) {
            msg = msg.trim();
            chatRoom.addMessage(new Message(chatter, msg, new java.util.Date().getTime()));
        }
%>
<HTML>
<HEAD>
    <LINK rel="stylesheet" type="text/css" href="chat.css">
    <META http-equiv="pragma" content="no-cache">
</HEAD>
<BODY onLoad="document.msg.messagebox.focus();" bgcolor="#FFFFFF">
<TABLE width="100%" cellpadding="3" cellspacing="0">
    <TR>
        <TD width="50%" align="left" valign="top">
            <TABLE>
                <TR>
                    <form name="msg" action="sendMessage.jsp" method="post">
                        <td>
                            <h2>Написать</h2>
                        </td>
                        <td width="100%">
                            <input type="text" name="<%=LoginServlet.PARAMETER_MESSAGESBOX%>" maxlength="300" size="35">
                            <input type="hidden" name="nickname"
                                   value="<%=session.getAttribute(LoginServlet.ATTRIBUTE_NICKNAME)%>">
                            <input name="submit" type="submit" value="Отправить">
                        </td>
                    </form>
                </TR>
            </TABLE>
        </TD>
    </TR>
</TABLE>
</BODY>
</HTML>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
